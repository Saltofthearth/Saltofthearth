# 🛠️ Sovereign & Autonomous AI Tooling Full Stack

This document defines the architectural specification, provider taxonomy, quota limits, and multi-provider failover routing strategy for the **Zero-Cost Sovereign AI Tooling Full Stack**.

For the production integration specification connecting off-the-shelf open-source projects (Aider, MCP/FastMCP, DSPy, Instructor, LiteLLM, LanceDB) under a strict No-Credit-Card / No-ID constraint, see **[`docs/AI_AUTOMATION_SPEC.md`](./docs/AI_AUTOMATION_SPEC.md)**.

Designed for high-throughput engineering, multimodal HCI, and autonomous agent orchestration driven by **Jules** alongside open-source local and cloud-free tier infrastructure.

---

## 🏗️ Architecture Overview

```
                          +------------------------------------------+
                          |   Human Operator / Autonomous Agent      |
                          |       (Jules, CLI/TUI, IDE Tools)        |
                          +------------------------------------------+
                                               |
                                               v
                          +------------------------------------------+
                          |      LiteLLM / Dynamic Quota Router      |
                          | (Key Rotation, Load Balancing, Failover) |
                          +------------------------------------------+
                                               |
       +-----------------------+---------------+---------------+-----------------------+
       |                       |                               |                       |
       v                       v                               v                       v
+---------------+     +-----------------+             +-----------------+     +-----------------+
| Tier 1: Fast  |     | Tier 2: Large   |             | Tier 3: Open    |     | Tier 4: Sovereign|
| LPUs          |     | Context Reasoning|            | Model Fallback  |     | Offline Fallback|
| (Groq /       |     | (Gemini 2.0     |             | (OpenRouter /   |     | (Ollama /       |
|  Cerebras)    |     |  Flash / Pro)   |             | Cloudflare AI)  |     |  llama.cpp)     |
+---------------+     +-----------------+             +-----------------+     +-----------------+
       |                       |                               |                       |
       +-----------------------+---------------+---------------+-----------------------+
                                               |
                                               v
                          +------------------------------------------+
                          |    Augmentation, Memory & Search       |
                          | - Vectors: Qdrant, Pinecone, LanceDB     |
                          | - Embeddings: HF Serverless, FastEmbed   |
                          | - Search: Tavily, Jina Reader, DuckDuckGo|
                          | - Speech: Groq Whisper, Local Whisper    |
                          +------------------------------------------+
```

---

## 📊 Layer 1: Inference & LLM Engine Matrix

To maximize productivity while incurring **$0 in API costs**, inference is distributed across multiple high-performance cloud free tiers with automatic failover to local runtimes.

| Provider | Primary Models | Free Tier Limits (RPM / TPM / RPD) | Strengths & Best Use Cases |
| :--- | :--- | :--- | :--- |
| **Groq Cloud** | `llama-3.3-70b-versatile`<br>`llama-3.1-8b-instant`<br>`deepseek-r1-distill-llama-70b` | **30 RPM** / **14.4k RPD**<br>6k–100k TPM (varies) | **Ultra-Fast LPUs (300-800 tok/s)**: Instant code generation, refactoring, agent tool-use loops. |
| **Cerebras** | `llama-3.3-70b`<br>`llama3.1-8b` | **30 RPM** / **60k TPM**<br>1,000,000 tokens/day | **Wafer-Scale Engine (1800-2000 tok/s)**: Sub-second completion for large code generation & refactor blocks. |
| **Google Gemini API** *(AI Studio)* | `gemini-2.0-flash`<br>`gemini-1.5-flash`<br>`gemini-1.5-pro` | **15 RPM** / **1M TPM** / **1.5k RPD** *(Flash)*<br>2 RPM / 32k TPM / 50 RPD *(Pro)* | **1M–2M Context Window**: Complex repository reasoning, video/audio multimodal understanding, long document synthesis. |
| **OpenRouter** *(Free Tier)* | `deepseek/deepseek-r1:free`<br>`meta-llama/llama-3.3-70b-instruct:free`<br>`qwen/qwen-2.5-coder-32b-instruct:free` | ~**20 RPM** (provider-dependent free pool) | **Model Diversity**: Access to frontier open-weights models and specialized coding models (`Qwen-2.5-Coder`). |
| **Cloudflare Workers AI** | `@cf/meta/llama-3.1-8b-instruct`<br>`@cf/deepseek-ai/deepseek-r1-distill-qwen-32b` | **10,000 Neurons/day** (~100k free tokens/day) | **Global Edge Execution**: Low-latency lightweight queries, fallback processing on Cloudflare's edge. |
| **Mistral AI** *(La Plateforme)* | `mistral-small`<br>`pixtral-12b` | Free experimentation rate limits | **Multimodal & European Sovereignty**: Code reasoning and vision evaluation. |
| **Cohere API** | `command-r`<br>`command-r-plus` | **10 RPM** free trial key | **RAG & Tool-Use**: Structured output, enterprise logic synthesis, and citations. |
| **Hugging Face** *(Serverless)* | Thousands of open-weights models | Free serverless rate limit (~1k–5k req/mo) | **Niche Models**: Access to domain-specific fine-tunes and specialized task models. |
| **Local Sovereign Engine** | `ollama` / `llama.cpp` (`deepseek-r1:8b`, `qwen2.5-coder:7b`) | **Unlimited** (Hardware bound) | **100% Offline & Private**: Zero data leakage, air-gapped fallback when quotas are exhausted. |

---

## 🧠 Layer 2: Embeddings, Vector Storage & Memory

| Component | Technology | Tier / Capacity | Best Use Case |
| :--- | :--- | :--- | :--- |
| **Vector DB (Cloud)** | **Qdrant Cloud** | 1 Free Cluster (1GB storage, ~100k 768-dim vectors) | Hybrid payload search, high-performance RAG indexing. |
| **Vector DB (Cloud)** | **Pinecone** | Free Starter Index (1 index, serverless free credits) | Fast similarity search for codebase semantic indexes. |
| **Vector DB (Edge)** | **Cloudflare Vectorize** | 5,000,000 vector query units/mo & 100k vectors | Distributed edge-cached vector retrieval. |
| **Vector DB (Local)** | **LanceDB / ChromaDB / DuckDB** | **100% Free / Unlimited** (Disk-bound embedded DBs) | Local code repository embeddings and persistent developer context. |
| **Embeddings API** | **FastEmbed (Local) / HF Serverless / CF AI** | Free CPU computation / Cloudflare 10k Neurons/day | Generating dense vector representations (`bge-small-en-v1.5`). |

---

## 🌐 Layer 3: Web Search & Knowledge Retrieval

| Tool / Service | API / Interface | Free Tier Quotas | Primary Function |
| :--- | :--- | :--- | :--- |
| **Tavily AI** | REST API | **1,000 queries/month** free | LLM-optimized web search & real-time factual synthesis. |
| **Exa.ai** | REST API | **1,000 queries/month** free | Neural semantic search across academic & technical web domains. |
| **Jina AI Reader** | `r.jina.ai/<URL>` | Free web scraping to markdown | Converting any web page/documentation into LLM-ready clean Markdown. |
| **DuckDuckGo CLI / SearXNG** | Python / Self-Hosted | **Unlimited** (Rate-limited scraping) | Zero-key fallback search for web retrieval. |

---

## 🗣️ Layer 4: Speech, Vision & Multimodal HCI

| Modality | Primary Provider | Free Quotas & Performance | Integration Method |
| :--- | :--- | :--- | :--- |
| **Speech-to-Text** | **Groq Whisper API** (`whisper-large-v3`) | ~2,000 audio seconds/hour (Ultra-fast) | Voice-to-intent pipeline for TUI / terminal navigation. |
| **Speech-to-Text** | **Whisper.cpp / Faster-Whisper** | Local / Unlimited | Offline voice command processing. |
| **Vision & Audio** | **Google Gemini 2.0 Flash** | 15 RPM / 1M TPM free | Analyzing UI screenshots, architectural diagrams, and video telemetry. |

---

## 🔀 Layer 5: Dynamic Multi-Provider Quota Router

To ensure uninterrupted service and high availability across free tiers, the stack uses **LiteLLM Proxy** as a local routing middleware.

### Fallback & Load-Balancing Strategy

1. **Primary Route**: Send requests to **Groq** or **Cerebras** for sub-second responses.
2. **Context Fallback**: If prompt length exceeds 32k tokens, auto-route to **Gemini 2.0 Flash** (1M context limit).
3. **429 Rate Limit Fallback**: On hitting a rate-limit error (429), immediately failover to **OpenRouter Free Tier** or **Cloudflare Workers AI**.
4. **Key Rotation**: Multiple free tier API keys per service are rotated in round-robin fashion using LiteLLM key pools.
5. **Offline Fallback**: If internet connectivity is down or all cloud quotas are reached, route seamlessly to local **Ollama** instance.

### Example LiteLLM Configuration (`config.yaml`)

```yaml
model_list:
  - model_name: gpt-4o # Unified virtual model name
    litellm_params:
      model: groq/llama-3.3-70b-versatile
      api_key: os.environ/GROQ_API_KEY_1
      rpm: 30
  - model_name: gpt-4o
    litellm_params:
      model: gemini/gemini-2.0-flash
      api_key: os.environ/GEMINI_API_KEY_1
      rpm: 15
  - model_name: gpt-4o
    litellm_params:
      model: openrouter/deepseek/deepseek-r1:free
      api_key: os.environ/OPENROUTER_API_KEY
  - model_name: gpt-4o
    litellm_params:
      model: ollama/qwen2.5-coder:7b
      api_base: http://localhost:11434

router_settings:
  routing_strategy: usage-based-routing-v2
  num_retries: 3
  retry_after: 1
  fallbacks: [{"gpt-4o": ["gemini/gemini-2.0-flash", "openrouter/deepseek/deepseek-r1:free", "ollama/qwen2.5-coder:7b"]}]
```

---

## 🤖 Agent Integration: Jules & Developer Tooling

- **Jules**: Operates as the central autonomous agent execution engine. Interfaces with LiteLLM to dispatch high-throughput code synthesis, plan creation, and continuous testing tasks without incurring costs.
- **CLI & TUI Tooling**:
  - `aider` / `continue.dev` configured to point to local LiteLLM proxy port (`http://localhost:4000`).
  - `jina reader` and `tavily` integrated for live documentation scraping during software design loops.
