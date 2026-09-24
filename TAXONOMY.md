# 🔬 Hierarchical Research Taxonomy & System Architecture

This document details the research fields, 3-layer system architecture taxonomy, and open-source software stack that form the foundation of our work in sovereign computing, information theory, computational linguistics, and human-computer interaction.

---

## 💻 3-Layer System Architecture Taxonomy

The operating system environment follows a 3-layer declarative taxonomy managed via the Nix package manager (without requiring a full NixOS installation) to provide reproducible, modular, and sovereign workstation configurations:

```
                            +-----------------------------------+
                            |    @md (Domain Modules)           |
                            |  AI, System Config, Servers, R&D  |
                            +-----------------------------------+
                                              |
                                              v
                            +-----------------------------------+
                            |    @ux (User Experience & HCI)    |
                            |  TUI, GUI, Audio, Hardware Input  |
                            +-----------------------------------+
                                              |
                                              v
                            +-----------------------------------+
                            |    @rt (Runtime Substrate & @cmd) |
                            | Shells, Coreutils, System Tooling |
                            +-----------------------------------+
```

### 1. `@rt` — Runtime Substrate & Core Utilities
- **Runtime Environment**: Core POSIX substrate, shell environments (Zsh/Bash/Fish), binary toolchains, environment environment drivers.
- **`@cmd` Userland Utilities**: High-performance Rust/C CLI toolings (`ripgrep`, `fd`, `eza`, `bat`, `fzf`, `jq`, `git`, `gnupg`).
- **Nix Declarative Substrate**: Nix Flakes & Home Manager modules anchoring tool versions deterministically across host distributions (Linux, OpenBSD, macOS).

### 2. `@ux` — User Experience, HCI & Modalities
- **TUI (Terminal User Interface)**: Terminal multiplexers (`tmux`, `zellij`), modal editors (`neovim`), ratatui-based monitors, and text-based navigation.
- **GUI (Graphical User Interface)**: Wayland compositors (Sway, Hyprland), GPU-accelerated terminals (`alacritty`, `kitty`, `foot`), and minimalist desktop setups.
- **Audio & Voice Processing**: PipeWire routing engine, low-latency DSP, spatial audio feedback, and local/cloud speech-to-intent engines.
- **Hardware Sensing & Input**: Keymaps for custom ergonomics (Azeron keypad chords, thumbstick controllers), biometric telemetry, and spatial movement tracking.

### 3. `@md` — Domain Modules & Research Subsystems
- **AI & Agentic Systems**: Local LLM runners (`ollama`, `llama.cpp`), vector stores (`qdrant`, `lancedb`), agentic toolchains (`Jules`), multi-provider LiteLLM routing.
- **Research & Knowledge Engine**: Archival tools, note-taking graph systems, LaTeX/Typst document compilers, and automated citation tools.
- **System Configuration & Infrastructure**: Encrypted network meshes (`wireguard`, `tailscale`), Tor/I2P routing, self-hosted services, and declarative backup tools.

---

## 🏛️ Research Pillars

```
Research Taxonomy
├── 1. Information Theory & Game Theory
├── 2. Linguistics, Phonetics & Assistive Technologies
├── 3. Functional Programming & Fullstack Integration
├── 4. World Knowledge Archiving & Category Fields
├── 5. Sovereignty, OpSec, Self-Hosting & DeFi
├── 6. Multimodal HCI, Novel UX & Hardware Sensing
└── 7. Predictive Systems Management (Power & Storage)
```

---

### 1. 🧠 Information Theory & Game Theory
- **Algorithmic Information Theory (AIT)**: Kolmogorov complexity, entropy metrics, and optimal data representation.
- **Game Theory & Mechanism Design**: Strategic equilibrium, consensus protocols, Byzantine fault tolerance, and game-theoretic incentives in peer-to-peer networks.
- **Coding Theory**: Error-correcting codes, lossless compression limits, and noise-tolerant communication protocols over untrusted networks.

---

### 2. 🗣️ Linguistics, Phonetics & Assistive Technologies
- **Phonetics & Phonology**: IPA transcription, speech signal synthesis, formant extraction, and acoustic phonetics.
- **Formal Grammars & Semantics**: Context-free grammars, type-logical grammars, and natural language processing pipelines.
- **Assistive Interaction & Accessibility**: Speech-to-intent mappings, eye-tracking interface integration, adaptive accessibility UI/UX, and voice-controlled terminal interfaces.

---

### 3. 💻 Functional Programming & Fullstack Integration
- **Pure Functional Languages**: Haskell, OCaml, Rust, Elixir, Nix.
- **Type Systems & Category Theory**: Monadic composition, algebraic data types, generalized algebraic data types (GADTs), dependent typing, and formal verification.
- **Fullstack Integration**: End-to-end type safety, GraphQL / gRPC schema driven APIs, reactive state management, and deterministic builds.

---

### 4. 📂 World Knowledge Archiving & Category Taxonomy
- **Knowledge Representation**: Hierarchical category trees, ontology mapping, semantic graph databases, and decentralized metadata formats.
- **Long-Term Preservation**: Cold storage architectures, immutable content-addressed storage (IPFS, Arweave), and bitrot prevention.
- **Universal Taxonomy**: Indexing multi-disciplinary research domains into structured, queryable knowledge repositories.

---

### 5. 🌐 Digital Sovereignty, OpSec, Self-Hosting & DeFi
- **Operational Security (OpSec)**: Cryptographic key hygiene, air-gapped secret management, threat modeling, and identity isolation.
- **Sovereign Infrastructure**: Self-hosted containerized services, NixOS declarative deployment, wire-guard mesh networks, and Tor/I2P routing.
- **DeFi & Cryptography**: Zero-knowledge proofs (ZKPs), decentralized finance protocols, smart contract auditability, and peer-to-peer financial autonomy.

---

### 6. ⚡ Multimodal HCI, Novel UX & Hardware Sensing
- **Modalities**:
  - **TUIs**: High-density, keyboard-driven terminal user interfaces (`curses`, `ratatui`).
  - **GUIs**: Declarative, composable graphical interfaces with custom window management (Wayland).
  - **Audio / Speech**: Low-latency voice control, spatial audio feedback, PipeWire signal processing.
- **Input Hardware & Ergonomics**:
  - **Azeron Keypad**: Custom keybinding layers, analog thumbstick navigation, and chorded macros.
  - **Biometric Sensors**: Biometric telemetry for adaptive UI focus and stress-responsive interface layouts.
  - **IoT & Gyroscopic Telemetry**: Mobile & IoT sensor integration (accelerometers, gyroscopes, spatial movement patterns).
- **Customization & Ricing**: Highly personalized Linux/BSD environments, dynamic color palette generation, and ergonomic window tiling.

---

### 7. 🔋 Predictive Systems Management
- **Predictive Power Management**: ML/heuristic power profiling for embedded/mobile systems, dynamic CPU governor optimization, and display power gating.
- **Predictive Storage Management**: Smart cache prefetching, tiering between NVMe/SSD/HDD based on usage prediction, and wear-leveling forecasting for persistent storage.

---

## 🛠️ Open Source Ecosystem Map

| Layer / Category | Primary Projects & Technologies |
| :--- | :--- |
| **Low-Level & Bootstrapping** | `coreboot`, `RISC-V`, `Limine`, `Booster`, `Toybox` |
| **OS, Substrate (`@rt`) & Init** | `OpenBSD`, `Skarnet s6` init suite, `Nix / NixOS`, `ZFS` |
| **User Experience (`@ux`)** | `Wayland` (Sway, Hyprland), `PipeWire`, `Ratatui`, `Neovim` |
| **Domain Subsystems (`@md`)** | `Ollama`, `LiteLLM`, `Qdrant`, `LanceDB`, `GnuPG`, `VeraCrypt` |
| **Enterprise & Systems Logic** | `Odoo` ERP |
