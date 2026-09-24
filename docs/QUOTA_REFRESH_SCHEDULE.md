# ⏳ Quota Refresh & Workload Rotation Schedule Specification

> **Operational Playbook for Dynamic Workload Routing, Quota Reset Synchronization, and High-Availability Multi-Tier Failover.**

---

## 🧭 1. Executive Summary

Because individual free tier quotas are finite, operating a continuous, high-throughput application across zero-cost cloud providers requires **dynamic workload rotation**. Workloads must seamlessly shift across providers based on quota reset timing cycles (hourly, daily, weekly, monthly) and consumed capacity.

This specification details:
1. Exact quota reset schedules across providers and time zones.
2. Workload routing, balancing, and failover algorithms.
3. Automated keep-alive/anti-dormancy heartbeats.
4. An automated Quota Health Check & Workload Scheduler script.

---

## ⏰ 2. Quota Refresh Schedule Matrix

| Provider & Service | Quota Metric | Reset Interval | Exact Reset Time (UTC) | Failover Destination |
| :--- | :--- | :--- | :--- | :--- |
| **Cloudflare Workers** | 100,000 Requests | Daily | `00:00 UTC` | GCP Cloud Run / AWS Lambda |
| **Cloudflare D1 SQL** | 5,000,000 Read Rows | Daily | `00:00 UTC` | Supabase Postgres / Neon Postgres |
| **Cloudflare KV** | 100,000 Reads | Daily | `00:00 UTC` | Upstash Redis |
| **GCP Cloud Run** | 2,000,000 Requests | Monthly | `1st of Month, 00:00 UTC` | Render / OCI Ampere VM |
| **GCP Cloud Build** | 120 Build Minutes | Daily | `00:00 UTC` | GitHub Actions / AWS CodeBuild |
| **Google AI Studio** | 1,500 Requests (Gemini) | Daily | `08:00 UTC (00:00 PST)` | Groq API / Hugging Face |
| **Groq API** | 14,400 Requests | Daily | `00:00 UTC` | Google AI Studio / Workers AI |
| **Upstash Redis** | 10,000 Commands | Daily | `00:00 UTC` | Cloudflare KV / DynamoDB |
| **AWS CloudFront** | 1 TB Egress Data | Monthly | `1st of Month, 00:00 UTC` | Cloudflare R2 / OCI Egress |
| **AWS Lambda** | 1,000,000 Requests | Monthly | `1st of Month, 00:00 UTC` | GCP Cloud Run |
| **OCI Egress** | 10 TB Egress Data | Monthly | `1st of Month, 00:00 UTC` | Cloudflare R2 / AWS CloudFront |
| **Kaggle Notebooks** | 30 GPU Hours | Weekly | `Rolling 7-day window` | Google Colab |

---

## 🔄 3. Workload Routing & Rotation Logic

### 3.1 Edge Request Routing Cascade
```
                     +---------------------------------------+
                     |         Incoming Client Request        |
                     +---------------------------------------+
                                         |
                                         v
                     +---------------------------------------+
                     | Primary: Cloudflare Worker            |
                     | Quota: 100k Req/Day                   |
                     +---------------------------------------+
                                         |
                        (If Consumed > 90k Req/Day)
                                         |
                                         v
                     +---------------------------------------+
                     | Secondary: GCP Cloud Run              |
                     | Quota: 2M Req/Month (~66k Req/Day)    |
                     +---------------------------------------+
                                         |
                       (If Consumed > 60k Req/Day)
                                         |
                                         v
                     +---------------------------------------+
                     | Tertiary: AWS Lambda                  |
                     | Quota: 1M Req/Month (~33k Req/Day)    |
                     +---------------------------------------+
                                         |
                        (If Consumed > 30k Req/Day)
                                         |
                                         v
                     +---------------------------------------+
                     | Fallback: OCI Ampere ARM VM           |
                     | Quota: Unlimited HTTP Requests        |
                     +---------------------------------------+
```

### 3.2 Database Read/Write Cascade
1. **Primary Cache Layer**: Upstash Redis (10,000 req/day). Upon reaching 9,000 requests, shift key-value caching to **Cloudflare Workers KV** (100,000 req/day).
2. **Primary Relational Store**: **Cloudflare D1** (5M reads/day). For complex queries or when D1 capacity exceeds 90%, route read queries to **Supabase Postgres** (500MB storage) or **Neon Postgres** (0.5GB storage).
3. **Primary NoSQL / Key-Value**: **AWS DynamoDB** (25 GB storage, 25 WCU / 25 RCU continuous).

---

## 💓 4. Anti-Dormancy Keep-Alive Playbook

To prevent free tier resources from being reclaimed due to idle policies:

1. **OCI Compute Idle Policy**: Requires >20% CPU or memory utilization.
   - *Mitigation*: Run a lightweight hourly background cron job executing a controlled CPU load spike (`stress-ng --cpu 1 --cpu-load 25 --timeout 300s`).
2. **Supabase Inactivity Pause**: Pauses project after 7 days of inactivity.
   - *Mitigation*: Daily GitHub Actions workflow (`.github/workflows/keepalive.yml`) performs a `SELECT 1;` query against the Supabase REST API endpoint.
3. **Render Web Service Inactivity**: Spins down container after 15 minutes of HTTP inactivity.
   - *Mitigation*: Ping health check route every 10 minutes via Cloudflare Worker cron trigger.

---

## 🛠️ 5. Automated Quota Scheduler Script

The Python script below (`infrastructure/scripts/quota_scheduler.py`) evaluates capacity across free tier APIs and dynamically determines optimal workload placement.

```python
#!/usr/bin/env python3
"""
Zero-Cost Multicloud Quota Health Check & Workload Scheduler
Evaluates available quotas across providers and outputs target execution endpoints.
"""

import json
import datetime
from typing import Dict, Any

# Define quota thresholds and current estimated daily consumption
QUOTA_LIMITS: Dict[str, Dict[str, Any]] = {
    "cloudflare_workers": {
        "daily_limit": 100000,
        "reset_utc": "00:00",
        "cadence": "daily",
        "type": "requests"
    },
    "gcp_cloud_run": {
        "monthly_limit": 2000000,
        "daily_target": 66000,
        "cadence": "monthly",
        "type": "requests"
    },
    "google_ai_studio": {
        "daily_limit": 1500,
        "reset_utc": "08:00",
        "cadence": "daily",
        "type": "llm_requests"
    },
    "groq_api": {
        "daily_limit": 14400,
        "reset_utc": "00:00",
        "cadence": "daily",
        "type": "llm_requests"
    },
    "upstash_redis": {
        "daily_limit": 10000,
        "reset_utc": "00:00",
        "cadence": "daily",
        "type": "commands"
    }
}

def resolve_llm_route(daily_llm_calls_made: int) -> str:
    """Selects optimal LLM provider based on current daily consumption."""
    if daily_llm_calls_made < 1400:
        return "google_ai_studio_gemini_2_0_flash"
    elif daily_llm_calls_made < (1400 + 13500):
        return "groq_llama_3_3_70b"
    else:
        return "cloudflare_workers_ai_llama_3_1_8b"

def resolve_compute_route(daily_http_requests_made: int) -> str:
    """Selects optimal compute tier based on current HTTP request load."""
    if daily_http_requests_made < 90000:
        return "cloudflare_workers"
    elif daily_http_requests_made < (90000 + 60000):
        return "gcp_cloud_run"
    elif daily_http_requests_made < (90000 + 60000 + 30000):
        return "aws_lambda"
    else:
        return "oci_ampere_arm_vm"

def generate_schedule_report(daily_llm_calls: int = 500, daily_http_reqs: int = 45000) -> Dict[str, Any]:
    now = datetime.datetime.now(datetime.timezone.utc)
    report = {
        "timestamp_utc": now.isoformat(),
        "selected_llm_target": resolve_llm_route(daily_llm_calls),
        "selected_compute_target": resolve_compute_route(daily_http_reqs),
        "quota_status": {
            "cloudflare_workers_usage_pct": round((daily_http_reqs / 100000) * 100, 2),
            "google_ai_studio_usage_pct": round((daily_llm_calls / 1500) * 100, 2)
        }
    }
    return report

if __name__ == "__main__":
    report = generate_schedule_report()
    print(json.dumps(report, indent=2))
