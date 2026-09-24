# 🌐 Zero-Cost & No-Verification Web Resource Mapping Specification

> **An Exhaustive Architectural Catalog and Mapping of Easily Acquirable Web Resources, APIs, Compute Tiers, and Data Services Operating Without Cost or ID Verification.**

---

## 🏛️ 1. Strategy & Acquisition Principles

This specification maps high-value web resources and infrastructure tiers accessible with **zero monetary cost** ($0) and **zero identity/credit card verification** (no passport/national ID upload, no payment card requirement).

### 🎯 Core Acquisition Taxonomy

Resources in this mapping are categorized by friction level and authorization model:

1. **Public / No-Auth (Zero Friction)**: Accessible via direct HTTP/REST endpoints with no registration, API keys, or accounts required.
2. **User Allowance / Private Auth (Email / GitHub OAuth Only)**: Accessible by creating a free account via standard email or GitHub SSO without credit card or ID verification.
3. **Partner / Business Allowances**: Shared community pools, developer tier credits, or multi-tenant free pools provided by platforms and foundation partners.

---

## 🤖 2. Generative AI, LLM & Machine Learning APIs

| Service / Provider | Acquisition Friction | Verification Required | Free Tier Allowance & Limits | Quota Reset Cadence | Key Strengths & Use Cases |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Google AI Studio** | Email / Google Account | **None** (No CC / No ID) | **Gemini 2.0 Flash**: 15 RPM, 1M TPM, 1,500 RPD<br>**Gemini 1.5 Pro**: 2 RPM, 32k TPM, 50 RPD | Daily (00:00 UTC) | 1M–2M token context window; ultra-fast multimodal reasoning; zero cost. |
| **Groq Cloud** | Email / GitHub SSO | **None** (No CC / No ID) | **Llama 3.3 70B**: 30 RPM, 14.4k RPD<br>**DeepSeek R1 Distill**: 30 RPM | Daily / Per-Minute | LPU wafer speed (300–800 tok/s); instant code synthesis and agent tool use. |
| **Cerebras Cloud** | Email / GitHub SSO | **None** (No CC / No ID) | **Llama 3.3 70B**: 30 RPM, 60k TPM, 1M tok/day | Daily / Per-Minute | Sub-second completion speeds (1800–2000 tok/s) on Wafer-Scale Engines. |
| **OpenRouter (Free Pool)** | Email / GitHub SSO | **None** (No CC / No ID) | ~20 RPM (Access to `deepseek/deepseek-r1:free`, `qwen/qwen-2.5-coder-32b-instruct:free`) | Dynamic / Hourly pool | Diverse open-weights model selection without credit card binding. |
| **Cloudflare Workers AI** | Email / Cloudflare Acct | **None** (No CC / No ID) | 10,000 Neurons / day (~100k free tokens/day across Llama 3.1 8B, DeepSeek R1 Distill) | Daily (00:00 UTC) | Global edge execution; zero-latency lightweight inference. |
| **Hugging Face Serverless** | Email / HF Account | **None** (No CC / No ID) | Thousands of open-weights models via Serverless API (~1k–5k requests/mo) | Continuous / Dynamic | Specialized domain models, embeddings, and task-specific classification. |
| **Mistral AI (La Plateforme)** | Email Registration | **None** (No CC / No ID) | Free trial tier for `mistral-small`, `pixtral-12b` | Dynamic rate limits | Multimodal code reasoning and open European model testing. |

---

## ⚡ 3. Serverless Compute, Edge Workers & Web Hosting

| Service / Platform | Acquisition Friction | Verification Required | Free Tier Allowance | Quota Reset Cadence | Ideal Workloads |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Cloudflare Workers** | Email / Cloudflare Acct | **None** (No CC / No ID) | **100,000 requests / day**, 128 MB RAM per subrequest, 10ms CPU time | Daily (00:00 UTC) | API routing, microservices, lightweight proxying, edge computation. |
| **Cloudflare Pages** | Email / Cloudflare Acct | **None** (No CC / No ID) | Unlimited static site hosting, 500 builds/month | Monthly calendar | Jamstack frontends, documentation portals, web dashboards. |
| **GCP Cloud Run** | Google Account | **None** for basic free allocation | 2,000,000 requests / month, 360,000 GB-seconds memory | Monthly calendar | Containerized microservices and stateless background workers. |
| **GitHub Actions** | GitHub Account | **None** (No CC / No ID) | **2,000 build-minutes / month** for private repos (unlimited for public repos) | Monthly calendar | CI/CD automation, scheduled quota checks, cron jobs. |
| **Vercel** | GitHub SSO / Email | **None** (No CC / No ID) | 100 GB bandwidth / month, Serverless function executions | Monthly calendar | Next.js deployment, serverless web applications. |
| **Netlify** | GitHub SSO / Email | **None** (No CC / No ID) | 100 GB bandwidth / month, 300 build minutes / month | Monthly calendar | Static site hosting, JAMstack deployment. |

---

## 🗄️ 4. Databases, Key-Value & Vector Storage

| Service / Platform | Acquisition Friction | Verification Required | Free Tier Allowance | Quota Reset Cadence | Primary Function |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Cloudflare D1 (SQL)** | Email / Cloudflare Acct | **None** (No CC / No ID) | 5 GB storage, 5,000,000 read rows / day, 100,000 write rows / day | Daily (00:00 UTC) | Serverless edge SQLite database. |
| **Cloudflare Workers KV** | Email / Cloudflare Acct | **None** (No CC / No ID) | 1 GB storage, 100,000 read requests / day, 1,000 write/delete / day | Daily (00:00 UTC) | Distributed key-value configuration and session storage. |
| **Upstash Redis** | Email / GitHub SSO | **None** (No CC / No ID) | 10,000 commands / day, max 256 MB storage | Daily (00:00 UTC) | High-speed memory cache, rate-limiting counters. |
| **Qdrant Cloud** | Email / GitHub SSO | **None** (No CC / No ID) | 1 Free Cluster (1 GB storage, ~100k 768-dim vectors) | Indefinite continuous | Hybrid vector database for RAG retrieval. |
| **Pinecone** | Email / GitHub SSO | **None** (No CC / No ID) | 1 Free Starter Index (serverless free allocation) | Indefinite continuous | Fast similarity search for code embeddings. |
| **Supabase** | GitHub SSO / Email | **None** (No CC / No ID) | 2 active projects, 500 MB Postgres DB, 1 GB Storage | Continuous (pauses if 7d idle) | Managed PostgreSQL with built-in REST API and Auth. |

---

## 🔍 5. Web Search, Scraping & Data Extraction

| Service / Endpoint | Acquisition Friction | Verification Required | Free Tier Allowance | Integration Method |
| :--- | :--- | :--- | :--- | :--- |
| **Jina AI Reader** | **Public / No-Auth** | **None** | Free web scraping to Markdown via `r.jina.ai/<URL>` | Direct REST / HTTP GET |
| **DuckDuckGo API / HTML** | **Public / No-Auth** | **None** | Unlimited (subject to standard web rate limiting) | Web scraping / Python DDGS library |
| **Tavily AI** | Email / GitHub SSO | **None** (No CC / No ID) | **1,000 search queries / month** | REST API (`/search`) |
| **Exa.ai** | Email / GitHub SSO | **None** (No CC / No ID) | **1,000 search queries / month** | REST API |
| **SearXNG / Public Nodes** | **Public / No-Auth** | **None** | Unlimited open meta-search across decentralized nodes | Public REST endpoints |

---

## 🔀 6. Fallback & Dynamic Routing Lifecycle

When orchestrating zero-cost workloads, the automated router follows a multi-tier fallback pipeline:

```
                          +-----------------------------------+
                          |     Incoming Request / Task       |
                          +-----------------------------------+
                                            |
                                            v
                          +-----------------------------------+
                          |  Tier 1: Public / No-Auth Endpoint |
                          |  (Jina Reader, DuckDuckGo, Local) |
                          +-----------------------------------+
                                            |
                                  (Auth Required / 429)
                                            v
                          +-----------------------------------+
                          | Tier 2: Zero-CC User Token Keys   |
                          | (Groq, Gemini, Cerebras, CF AI)   |
                          +-----------------------------------+
                                            |
                                  (Quota Exhausted / 429)
                                            v
                          +-----------------------------------+
                          | Tier 3: Partner / Public Pools    |
                          | (OpenRouter Free, HF Serverless)  |
                          +-----------------------------------+
                                            |
                                     (Offline / Fallback)
                                            v
                          +-----------------------------------+
                          | Tier 4: Sovereign Local Fallback  |
                          | (Ollama, llama.cpp, FastEmbed)    |
                          +-----------------------------------+
```
