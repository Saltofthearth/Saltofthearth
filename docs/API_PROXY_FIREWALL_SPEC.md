# 🛡️ Declarative API Proxy, Web Firewall & Isolation Architecture

> **Specification for a Zero-Trust API Proxy Gateway and Inbound/Outbound Web Firewall Protecting Internal Workloads and User Environments.**

---

## 🏛️ 1. Architecture Principles & Scope

To ensure absolute privacy, security, and operational isolation when leveraging web resources, external APIs, and agentic LLMs:

1. **Zero Raw Personal Data Storage**: No raw payment cards, government identity documents, or remote control telemetry are stored within codebase repositories, environment variables, or execution logs.
2. **Egress Filtering & Web Firewalling**: All outgoing web requests from autonomous agent workers and internal services are routed through an egress proxy firewall that enforces domain allowlisting, rate limiting, and request sanitization.
3. **Environment Secret Vaulting**: All API tokens (Groq, Gemini, Cloudflare, etc.) are injected purely via runtime environment variables (`GROQ_API_KEY`, `GEMINI_API_KEY`) or secrets management proxies, keeping credentials completely decoupled from code.
4. **Isolated Proxy Gateway**: Acts as a protective barrier between the external internet and local developer/agent execution layers.

---

## 📐 2. Egress Firewall & API Proxy Pipeline

```
+-----------------------------------------------------------------------+
|                 Autonomous Agent / Local Runtime                      |
|                  (Jules / CLI / Nix Environment)                      |
+-----------------------------------------------------------------------+
                                   |
                                   v (Internal HTTP/HTTPS Egress)
+-----------------------------------------------------------------------+
|                    Local / Edge Egress Firewall                       |
|   - Domain Allowlisting (api.groq.com, generativelanguage.googleapis)  |
|   - Request Sanitization (Filter header leaks / local IP leaks)       |
|   - Token Injection (Attaches API keys securely from env secrets)     |
+-----------------------------------------------------------------------+
                                   |
                                   v (Proxied & Filtered Web Request)
+-----------------------------------------------------------------------+
|                   External Zero-Cost Web APIs                         |
|      (Groq LPUs, Gemini Flash, Jina Reader, Cloudflare Workers)       |
+-----------------------------------------------------------------------+
```

---

## 🛠️ 3. Egress Rule Specification (`infrastructure/proxy/egress_rules.json`)

Below is the declarative configuration for allowed outbound destinations, rate limits, and proxy headers:

```json
{
  "firewall_version": "1.0",
  "policy": "strict_egress_allowlist",
  "allowed_destinations": [
    {
      "domain": "generativelanguage.googleapis.com",
      "category": "llm_inference",
      "required_env_key": "GEMINI_API_KEY",
      "max_requests_per_minute": 15
    },
    {
      "domain": "api.groq.com",
      "category": "llm_inference",
      "required_env_key": "GROQ_API_KEY",
      "max_requests_per_minute": 30
    },
    {
      "domain": "api.cerebras.ai",
      "category": "llm_inference",
      "required_env_key": "CEREBRAS_API_KEY",
      "max_requests_per_minute": 30
    },
    {
      "domain": "openrouter.ai",
      "category": "llm_inference",
      "required_env_key": "OPENROUTER_API_KEY",
      "max_requests_per_minute": 20
    },
    {
      "domain": "r.jina.ai",
      "category": "web_scraping",
      "required_env_key": null,
      "max_requests_per_minute": 60
    },
    {
      "domain": "html.duckduckgo.com",
      "category": "web_search",
      "required_env_key": null,
      "max_requests_per_minute": 30
    }
  ],
  "blocked_actions": [
    "raw_card_number_transmission",
    "government_id_document_upload",
    "unencrypted_http_egress",
    "unauthorized_ip_binding"
  ]
}
```

---

## 🔒 4. Operational Security & Verification Checklist

- [x] **No Credit Card / Payment Card Binding**: All listed APIs execute on $0 free allocations without payment method requirements.
- [x] **No ID Uploads Required**: Zero requirement for national ID/passport submissions.
- [x] **Stateless Runtime Isolation**: All API tokens injected exclusively at execution time via environment secrets.
