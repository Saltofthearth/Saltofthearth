# 🤖 Zero-Cost & No-CC/No-ID AI Automation Architecture Specification

> **A Production-Grade Specification for Connecting Established Open-Source AI Technologies into an Unclogged, Autonomous Live Production Pipeline.**

---

## 🧭 1. Executive Summary & Vision

The primary bottleneck in modern autonomous AI engineering is not the lack of capable foundational models, but **pipeline friction**: fragmented tool interfaces, fragile prompt templates, schema drift in structured outputs, rate-limit failures, and credit card/identity gating.

This specification defines a sovereign, zero-cost AI automation architecture designed to **unclog the pipeline to full live production**. By integrating established, battle-tested open-source projects—including **LiteLLM**, **Model Context Protocol (MCP)**, **Aider**, **DSPy**, **Instructor**, **LanceDB**, **Jina Reader**, and **Ollama**—this architecture achieves autonomous execution with:
1. **$0 Financial Cost & Zero Identity Friction**: Strictly utilizes providers that require **NO Credit Card (CC)** and **NO Identity Verification (ID)**.
2. **Infinite Multi-Provider Resilience**: Automated multi-tier failover across free cloud APIs and offline local runtimes.
3. **Deterministic Tool & Schema Enforcement**: Type-safe tool calling via MCP and JSON schema validation via Instructor/Pydantic.
4. **Self-Improving Prompt Engineering**: Declarative optimization of agent reasoning signatures using DSPy.

---

## 🏗️ 2. Architectural Blueprint & Component Map

The architecture connects best-in-class open-source projects into four distinct, loosely coupled layers:

```
+-----------------------------------------------------------------------------------+
|                           1. EXECUTION & HARNESS LAYER                            |
|  - Aider CLI / Agent Harness (Autonomous code edit loops & git commits)           |
|  - DSPy (Declarative prompt signatures & self-optimizing pipelines)               |
|  - Model Context Protocol (MCP / FastMCP) (Standardized tool & context interface)  |
+-----------------------------------------------------------------------------------+
                                         |
                                         v
+-----------------------------------------------------------------------------------+
|                        2. INFERENCE & ROUTING PIPELINE                             |
|  - LiteLLM Proxy (Unified OpenAI-compatible endpoint, key rotation, failover)     |
|  - Instructor / Pydantic (Type-safe schema validation & auto-retry on syntax error)|
|  - Outlines / Guidance (Grammar-constrained sampling & deterministic decoding)    |
+-----------------------------------------------------------------------------------+
                                         |
                                         v
+-----------------------------------------------------------------------------------+
|                       3. NO-CC / NO-ID PROVIDER POOL                               |
|  - Tier 1: Groq Cloud (Ultra-fast LPU: Llama 3.3 70B, DeepSeek R1 Distill)        |
|  - Tier 2: Google Gemini AI Studio (1M-2M Context Window: Gemini 2.0 Flash)       |
|  - Tier 3: OpenRouter Free Tier (Model diversity: Qwen 2.5 Coder, DeepSeek R1)    |
|  - Tier 4: Hugging Face Serverless (Niche open weights models)                   |
|  - Tier 5: Sovereign Local Engine (Ollama / llama.cpp - 100% offline fallback)    |
+-----------------------------------------------------------------------------------+
                                         |
                                         v
+-----------------------------------------------------------------------------------+
|                      4. RETRIEVAL, GROUNDING & MEMORY                             |
|  - Jina Reader API (r.jina.ai) (Zero-key web-to-clean-markdown scraping)          |
|  - DuckDuckGo Search (Zero-key web search integration)                            |
|  - LanceDB / DuckDB (Embedded, zero-cost vector & relational memory)              |
+-----------------------------------------------------------------------------------+
```

---

## 🔐 3. Strict No-CC / No-ID Provider Matrix

To eliminate onboarding friction, API locks, and billing risks, all external inference endpoints must meet the **Zero-CC / Zero-ID Standard**: free registration using standard OAuth/email with **no credit card entry** and **no phone/ID verification**.

| Provider | Access Endpoint | Free Tier Allowance | No-CC / No-ID Verified | Primary Role in Pipeline |
| :--- | :--- | :--- | :--- | :--- |
| **Google Gemini API** *(AI Studio)* | `https://generativelanguage.googleapis.com` | **15 RPM / 1M TPM / 1,500 RPD** *(Gemini 2.0 Flash)* | ✅ YES | **Long-Context Reasoning**: Repositories, large diffs, video/audio multimodal analysis (1M context). |
| **Groq Cloud API** | `https://api.groq.com/openai/v1` | **30 RPM / 14,400 RPD** *(Llama 3.3 70B: 6k TPM)* | ✅ YES | **Sub-Second Execution**: Fast code generation, refactoring, and tool calling loops (300-800 tok/s). |
| **OpenRouter Free Tier** | `https://openrouter.ai/api/v1` | ~**20 RPM** free pool (`:free` suffix models) | ✅ YES | **Model Diversity**: `deepseek/deepseek-r1:free`, `qwen/qwen-2.5-coder-32b-instruct:free`. |
| **Hugging Face Serverless** | `https://api-inference.huggingface.co` | Free serverless rate limit | ✅ YES | **Specialized Fine-Tunes**: Domain-specific coding and syntax evaluation models. |
| **Local Sovereign Ollama** | `http://localhost:11434` | **Unlimited** (Hardware bound) | ✅ 100% Offline | **Air-Gapped Fallback**: Zero-leakage execution when all external cloud quotas are exhausted. |

---

## ⚙️ 4. Detailed Component Specifications

### 4.1 Execution & Harness Layer (Aider, DSPy & MCP)

#### A. Aider Engine Integration
- **Role**: Serves as the continuous git-aware code execution harness.
- **Specification**: Configured to direct all LLM calls to the local **LiteLLM Proxy** endpoint (`http://localhost:4000`). Utilizes architect mode (`--architect`) to separate high-level planning from low-level editing.
- **Git Guardrail**: Auto-commits code changes on successful verification and rolls back changes on test failures.

#### B. Model Context Protocol (MCP) Integration
- **Role**: Standardizes how agent harnesses access environment tools (filesystem, git, documentation search, web scraping).
- **FastMCP Server Specification**:
  - `mcp-server-git`: Provides repository status, diff analysis, and log inspection.
  - `mcp-server-jina`: Wraps Jina Reader (`r.jina.ai`) for zero-key web documentation retrieval.
  - `mcp-server-ddg`: Provides DuckDuckGo search results in clean Markdown format.

```json
{
  "mcpServers": {
    "jina-reader": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."]
    },
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "."]
    }
  }
}
```

#### C. DSPy Signature Optimization
- **Role**: Replaces manual prompt engineering with compiled, declarative prompt signatures.
- **Specification**: Defines signatures for `CodeRefactor`, `BugDiagnosis`, and `TestGeneration`. Automatically evaluates pipeline outputs against test suites to optimize prompt instructions without manual tuning.

```python
import dspy

class CodeRefactorSignature(dspy.Signature):
    """Refactor code to meet strict type-safety and performance requirements."""
    context = dspy.InputField(desc="Existing codebase context and interfaces")
    issue_description = dspy.InputField(desc="Task or bug description")
    refactored_code = dspy.OutputField(desc="Type-safe updated code block with inline docs")

class AutonomousRefactorPipeline(dspy.Module):
    def __init__(self):
        super().__init__()
        self.prog = dspy.ChainOfThought(CodeRefactorSignature)

    def forward(self, context, issue_description):
        return self.prog(context=context, issue_description=issue_description)
```

---

### 4.2 Inference & Routing Pipeline (LiteLLM, Instructor & Outlines)

#### A. LiteLLM Dynamic Quota Router Configuration
- **Role**: Unified OpenAI-compatible proxy handling key rotation, load balancing, rate-limit fallback (429), and model translation across No-CC providers.

```yaml
model_list:
  # Primary Fast Model (Groq)
  - model_name: sovereign-fast
    litellm_params:
      model: groq/llama-3.3-70b-versatile
      api_key: os.environ/GROQ_API_KEY
      rpm: 30
      rpd: 14400

  # Long-Context Reasoning Model (Gemini 2.0 Flash)
  - model_name: sovereign-reasoning
    litellm_params:
      model: gemini/gemini-2.0-flash
      api_key: os.environ/GEMINI_API_KEY
      rpm: 15
      tpm: 1000000

  # Free Model Diversity (OpenRouter)
  - model_name: sovereign-fallback
    litellm_params:
      model: openrouter/deepseek/deepseek-r1:free
      api_key: os.environ/OPENROUTER_API_KEY

  # Sovereign Local Fallback (Ollama)
  - model_name: sovereign-local
    litellm_params:
      model: ollama/qwen2.5-coder:7b
      api_base: http://localhost:11434

router_settings:
  routing_strategy: usage-based-routing-v2
  num_retries: 3
  retry_after: 1
  cooldown_time: 60
  fallbacks:
    - sovereign-fast: ["sovereign-reasoning", "sovereign-fallback", "sovereign-local"]
    - sovereign-reasoning: ["sovereign-fast", "sovereign-fallback", "sovereign-local"]
```

#### B. Instructor Schema Validation
- **Role**: Enforces strict Pydantic JSON outputs from LLMs, eliminating JSON parsing errors and syntax drift.
- **Auto-Retry Specification**: If an LLM output fails Pydantic validation, Instructor automatically feeds the validation error back to the LLM for self-correction (up to 3 retries).

```python
from pydantic import BaseModel, Field
from typing import List
import instructor
from openai import OpenAI

client = instructor.from_openai(
    OpenAI(base_url="http://localhost:4000", api_key="sk-litellm-proxy")
)

class RefactorPlanStep(BaseModel):
    step_number: int
    filepath: str
    action: str = Field(description="Description of specific edits to apply")
    verification_command: str = Field(description="Command to run to verify step success")

class RefactorPlan(BaseModel):
    plan_title: str
    steps: List[RefactorPlanStep]

def generate_plan(task_prompt: str) -> RefactorPlan:
    return client.chat.completions.create(
        model="sovereign-fast",
        response_model=RefactorPlan,
        messages=[{"role": "user", "content": task_prompt}],
        max_retries=3
    )
```

---

### 4.3 Knowledge Retrieval, Grounding & Local Storage

To keep the pipeline grounded in factual documentation without requiring paid search APIs:

1. **Jina Reader API (`r.jina.ai`)**:
   - Usage: Prefix any documentation URL with `https://r.jina.ai/` to retrieve LLM-optimized Markdown.
   - Example: `curl https://r.jina.ai/https://docs.opentofu.org/docs/intro/`
   - Cost: $0, no API key required.

2. **DuckDuckGo Zero-Key Web Search**:
   - Integrated via Python package `duckduckgo-search` or MCP server.
   - Performs lightweight technical searches when documentation URLs are not known beforehand.

3. **LanceDB Embedded Vector Memory**:
   - Zero-cost, serverless vector database running embedded within the local process.
   - Stores code symbol embeddings (`bge-small-en-v1.5` via FastEmbed CPU) for instant local code retrieval.

---

## 🔄 5. Pipeline State Machine & Failover Execution Flow

```
                      +---------------------------------------+
                      |       Task Execution Requested        |
                      +---------------------------------------+
                                          |
                                          v
                      +---------------------------------------+
                      |  Context Window & Size Evaluator     |
                      +---------------------------------------+
                        /                                   \
         (Prompt > 32k Tokens)                       (Prompt <= 32k Tokens)
                      /                                       \
                     v                                         v
   +------------------------------------+    +------------------------------------+
   | Route: Gemini 2.0 Flash            |    | Route: Groq Llama 3.3 70B          |
   | (1M Context Window)                |    | (Sub-second execution)             |
   +------------------------------------+    +------------------------------------+
                     \                                         /
                      +-------------------+-------------------+
                                          |
                                (HTTP 429 / Quota Limit)
                                          |
                                          v
                      +---------------------------------------+
                      | Failover: OpenRouter Free Tier        |
                      | (DeepSeek R1 / Qwen 2.5 Coder)        |
                      +---------------------------------------+
                                          |
                               (Cloud Unreachable / Offline)
                                          |
                                          v
                      +---------------------------------------+
                      | Fallback: Local Ollama Instance       |
                      | (Qwen2.5-Coder 7B / DeepSeek R1 8B)   |
                      +---------------------------------------+
                                          |
                                          v
                      +---------------------------------------+
                      | Instructor / Pydantic Schema Check    |
                      | - Valid? Pass to Execution Harness    |
                      | - Invalid? Auto-retry with errors     |
                      +---------------------------------------+
                                          |
                                          v
                      +---------------------------------------+
                      | Aider Harness Executed & Tests Checked|
                      | - Success: Git Commit & Sign          |
                      | - Failure: Revert & Retry Loop        |
                      +---------------------------------------+
```

---

## 🛠️ 6. Verification & Operational Deployment

To verify that the specification is fully operational in a local development environment:

1. **LiteLLM Proxy Start**:
   ```bash
   litellm --config config/litellm_config.yaml --port 4000
   ```
2. **MCP Tool Test**:
   ```bash
   npx @modelcontextprotocol/inspector npx @modelcontextprotocol/server-filesystem .
   ```
3. **End-to-End Pipeline Health Check**:
   - Send test request to LiteLLM Proxy endpoint.
   - Verify zero-cost failover by disconnecting network or mocking 429 response.
   - Verify Instructor schema enforcement and local LanceDB index creation.
