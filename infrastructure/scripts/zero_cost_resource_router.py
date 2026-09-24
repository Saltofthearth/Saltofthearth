#!/usr/bin/env python3
"""
Zero-Cost Resource Router & Quota Health Manager
Automates evaluation of public (no-auth), private token, and partner zero-cost web resources.
"""

import os
import json
import datetime
from typing import Dict, Any, List

# Catalog of zero-cost, no-verification web resources
ZERO_COST_CATALOG: Dict[str, Any] = {
    "public_no_auth": [
        {
            "id": "jina_reader",
            "name": "Jina AI Reader",
            "category": "web_scraping",
            "auth_type": "none",
            "verification_required": None,
            "endpoint": "https://r.jina.ai/",
            "quota_daily": None
        },
        {
            "id": "duckduckgo_search",
            "name": "DuckDuckGo HTML/API",
            "category": "web_search",
            "auth_type": "none",
            "verification_required": None,
            "endpoint": "https://html.duckduckgo.com/html/",
            "quota_daily": None
        }
    ],
    "user_allowances": [
        {
            "id": "google_ai_studio",
            "name": "Google AI Studio (Gemini 2.0 Flash)",
            "category": "llm_inference",
            "auth_type": "api_key",
            "env_var": "GEMINI_API_KEY",
            "verification_required": None,
            "quota_daily": 1500,
            "quota_tpm": 1000000,
            "rpm": 15
        },
        {
            "id": "groq_cloud",
            "name": "Groq LPU (Llama 3.3 70B)",
            "category": "llm_inference",
            "auth_type": "api_key",
            "env_var": "GROQ_API_KEY",
            "verification_required": None,
            "quota_daily": 14400,
            "rpm": 30
        },
        {
            "id": "cerebras_cloud",
            "name": "Cerebras Engine (Llama 3.3 70B)",
            "category": "llm_inference",
            "auth_type": "api_key",
            "env_var": "CEREBRAS_API_KEY",
            "verification_required": None,
            "quota_daily": 1000000,  # 1M tokens/day
            "rpm": 30
        },
        {
            "id": "cloudflare_workers",
            "name": "Cloudflare Workers Execution",
            "category": "compute",
            "auth_type": "api_key",
            "env_var": "CLOUDFLARE_API_TOKEN",
            "verification_required": None,
            "quota_daily": 100000
        },
        {
            "id": "upstash_redis",
            "name": "Upstash Serverless Redis",
            "category": "database_kv",
            "auth_type": "api_key",
            "env_var": "UPSTASH_REDIS_REST_TOKEN",
            "verification_required": None,
            "quota_daily": 10000
        }
    ],
    "partner_allowances": [
        {
            "id": "openrouter_free_pool",
            "name": "OpenRouter Free Models",
            "category": "llm_inference",
            "auth_type": "api_key",
            "env_var": "OPENROUTER_API_KEY",
            "verification_required": None,
            "quota_daily": 1000
        },
        {
            "id": "huggingface_serverless",
            "name": "Hugging Face Serverless API",
            "category": "embeddings_and_llm",
            "auth_type": "api_key",
            "env_var": "HF_TOKEN",
            "verification_required": None,
            "quota_daily": 5000
        }
    ]
}

def check_active_credentials() -> Dict[str, bool]:
    """Evaluates which user/partner credentials are present in the environment."""
    status = {}
    for tier in ["user_allowances", "partner_allowances"]:
        for resource in ZERO_COST_CATALOG[tier]:
            env_var = resource.get("env_var")
            if env_var:
                status[resource["id"]] = bool(os.getenv(env_var))
    return status

def select_optimal_llm_route(daily_calls_made: int) -> Dict[str, Any]:
    """Selects the best available zero-cost LLM route based on credentials and current usage."""
    creds = check_active_credentials()

    # Priority 1: Gemini 2.0 Flash (1500 RPD) if key present and usage < 1400
    if creds.get("google_ai_studio") and daily_calls_made < 1400:
        return {
            "target": "google_ai_studio",
            "model": "gemini-2.0-flash",
            "tier": "user_allowances",
            "verification_status": "No CC / No ID required"
        }
    # Priority 2: Groq LPU (14,400 RPD) if key present
    elif creds.get("groq_cloud") and daily_calls_made < 15000:
        return {
            "target": "groq_cloud",
            "model": "llama-3.3-70b-versatile",
            "tier": "user_allowances",
            "verification_status": "No CC / No ID required"
        }
    # Priority 3: Cerebras Wafer Engine
    elif creds.get("cerebras_cloud"):
        return {
            "target": "cerebras_cloud",
            "model": "llama3.1-70b",
            "tier": "user_allowances",
            "verification_status": "No CC / No ID required"
        }
    # Priority 4: OpenRouter Free Pool
    elif creds.get("openrouter_free_pool"):
        return {
            "target": "openrouter_free_pool",
            "model": "deepseek/deepseek-r1:free",
            "tier": "partner_allowances",
            "verification_status": "No CC / No ID required"
        }
    # Priority 5: Sovereign Local Fallback
    else:
        return {
            "target": "local_ollama",
            "model": "qwen2.5-coder:7b",
            "tier": "sovereign_local",
            "verification_status": "Offline / Zero Auth Required"
        }

def generate_routing_report(daily_llm_calls: int = 250) -> Dict[str, Any]:
    now = datetime.datetime.now(datetime.timezone.utc)
    llm_route = select_optimal_llm_route(daily_llm_calls)
    credentials_status = check_active_credentials()

    return {
        "timestamp_utc": now.isoformat(),
        "selected_llm_route": llm_route,
        "public_no_auth_available": [r["id"] for r in ZERO_COST_CATALOG["public_no_auth"]],
        "active_credentials": credentials_status,
        "total_configured_resources": len(ZERO_COST_CATALOG["public_no_auth"]) + len(ZERO_COST_CATALOG["user_allowances"]) + len(ZERO_COST_CATALOG["partner_allowances"])
    }

if __name__ == "__main__":
    report = generate_routing_report()
    print(json.dumps(report, indent=2))
