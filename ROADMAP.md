# 🗺️ Hierarchy of Priority Work & Repository Roadmap

This document outlines the strategic hierarchy of priority work for the repository. To maximize productivity and focus resources on what is most relevant for the current status of the project, all technical endeavors and development initiatives are organized into a strict two-pillar priority model:

```
Hierarchy of Priority Work
├── 🏛️ PRIORITY #1: Repository Architecture (Core Substrate & Systems)
└── 🤖 PRIORITY #2: AI Automation (Zero-Cost Sovereign AI Stack & Workflows)
```

---

## 🏛️ PRIORITY #1: Repository Architecture (Core Substrate & Systems)

*The absolute baseline foundation. Without a declarative, type-safe, and deterministic architecture, higher-level automation cannot operate reliably.*

### Key Objectives & Components
1. **Sovereign OS Taxonomy (`@rt`, `@ux`, `@md`)**:
   - **`@rt` (Runtime Substrate & `@cmd` Userland)**:
     - Boot, firmware (Limine, Booster), core libraries (glibc, OpenSSL), and filesystem utilities (OpenZFS, Btrfs).
     - Non-systemd init supervision tree templates using Skarnet `s6` / `s6-rc` / `execline`.
     - Automated ZFS snapshot-on-build hooks for instant rollbacks during Nix updates.
   - **`@ux` (User Experience & HCI)**:
     - Terminal User Interfaces (`ratatui`, `tmux`, `fzf`).
     - Wayland Compositor management (`sway`, `hyprland`, `foot`, `mako`).
     - PipeWire low-latency audio stack integration.
     - Custom hardware input drivers & mappings (e.g., Azeron keypad analog bindings).
   - **`@md` (Domain & System Management Modules)**:
     - Declarative state management via Home-Manager.
     - System monitoring, power management (`powertop`, `tlp`), and decentralized archiving (`restic`, `ipfs`).

2. **Nix Flake & Declarative Environment Standard**:
   - Pure Nix packaging for all stack components across `@rt`, `@ux`, and `@md`.
   - Hermetic developer environments (`nix develop .#rt`, `nix develop .#ux`, `nix develop .#md`, `nix develop .#default`).

3. **Zero-Cost Multicloud IaC (OpenTofu)**:
   - Modular OpenTofu configurations (`infrastructure/opentofu/`) maximizing cloud always-free tiers (OCI, GCP, AWS, Cloudflare, Supabase, B2).
   - Dynamic quota refresh scheduler (`quota_scheduler.py`) and zero-dollar spend guardrails.

---

## 🤖 PRIORITY #2: AI Automation (Zero-Cost Sovereign AI Stack & Workflows)

*Leveraging high-throughput agentic workflows, multi-provider inference routing, and local sovereign LLMs to accelerate development on top of the established architecture.*

### Key Objectives & Components
1. **Autonomous Agent Execution Engine (Jules)**:
   - Deep planning, multi-turn requirement verification, autonomous code synthesis, and deterministic testing loops.
   - Strict OpSec, GPG-signed commits, and pre-commit guardrails.

2. **Dynamic Multi-Provider AI Router (LiteLLM / Quota Router)**:
   - Multi-provider zero-cost routing across ultra-fast LPUs (Groq, Cerebras), large-context engines (Gemini 2.0 Flash - 1M context window), and open-model fallbacks (OpenRouter, Cloudflare Workers AI).
   - Rate-limit handling (429 failover) and key rotation.
   - Sovereign offline fallback using local `ollama` / `llama.cpp` (`deepseek-r1:8b`, `qwen2.5-coder:7b`).

3. **Knowledge Retrieval & Multimodal HCI Integration**:
   - Semantic RAG and vector indexing (Qdrant, Pinecone, LanceDB).
   - Web documentation scraping and research synthesis (Tavily, Exa.ai, Jina AI Reader).
   - PipeWire audio stream to Whisper speech-to-intent execution bridge for voice-controlled terminal interfaces.

---

## 🎯 Immediate Priority Action Matrix

| Priority Level | Domain | Item / Task | Status / Action Needed |
| :--- | :--- | :--- | :--- |
| **Priority 1** | `@rt/@cmd` | `s6` Supervision Service Templates | **Active**: Provide declarative `/etc/s6/services` templates in `nix/rt/cmd`. |
| **Priority 1** | `@rt/@cmd` | ZFS Snapshot Hooks | **Active**: Implement build-time ZFS auto-snapshot scripts for Nix profile generations. |
| **Priority 1** | IaC / Infrastructure | OpenTofu IaC Validation | **Active**: Validate zero-cost cloud allocation modules in `infrastructure/opentofu/`. |
| **Priority 2** | `@ux` + `@md` | PipeWire -> Whisper Bridge | **Next**: Build low-latency speech-to-intent CLI daemon bridging PipeWire audio to Whisper.cpp. |
| **Priority 2** | AI Stack | Zero-Cost No-ID Resource Router | **Done**: Added `zero_cost_resource_router.py` & `ZERO_COST_RESOURCE_MAPPING.md` mapping easily acquirable web resources with $0 cost and 0 ID verification. |
| **Priority 2** | AI Stack | LiteLLM Failover Router | **Next**: Finalize local LiteLLM proxy configuration with automatic Groq/Gemini/Ollama failover. |
| **Priority 2** | `@ux` + `@md` | Azeron Wayland Mappings | **Backlog**: Map chorded keypad analog thumbstick to Sway/Hyprland window actions. |

---

*This roadmap is evaluated and updated continuously as repository goals evolve.*
