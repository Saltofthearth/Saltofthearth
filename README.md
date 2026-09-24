# 👋 Welcome to My GitHub Profile

> **Sovereign Systems Engineer, Computational Linguist & Systems Researcher**
> *Exploring the intersection of Functional Programming, Information & Game Theory, Multimodal HCI, Digital Sovereignty, and AI-Augmented Engineering.*

---

## 🚀 Sovereign OS Taxonomy Stack Demo & Nix Architecture

A declarative demo of the Sovereign OS stack architecture managed purely via the **Nix package manager** and **Flakes** (without requiring full NixOS).

### 📐 Stack Hierarchy

```
Sovereign OS Architecture
├── ⚡ @rt (Runtime / Base System Foundation)
│   ├── 🔌 Boot, Drivers & Kernel Substrate (Limine, Booster, kmod, pciutils, usbutils)
│   └── 💻 @cmd (Core Userland Execution Environment)
│       ├── shell   : (Bash, Zsh, Nushell)
│       ├── libs    : (Glibc, OpenSSL, Zlib, Ncurses)
│       ├── init    : (Skarnet s6, s6-rc, Execline)
│       ├── fs      : (OpenZFS, Ext4, Btrfs, FAT32)
│       ├── utils   : (Toybox, Coreutils, Util-Linux)
│       └── pkgman  : (Nix Package Manager)
│
├── 🎨 @ux (User Experience & HCI)
│   ├── tui   : (Ratatui, Tmux, Htop, Fzf)
│   ├── gui   : (Wayland, Sway, Hyprland, Foot, Mako)
│   └── audio : (PipeWire, WirePlumber, Pavucontrol, ALSA)
│
└── 🧠 @md (Domain & System Management Modules)
    ├── ai             : (Whisper.cpp, Ollama local inference)
    ├── server         : (WireGuard mesh networking, Matrix decentralized comms)
    ├── system config  : (Home-Manager declarative state, Git)
    ├── manual         : (MdBook documentation engine, Man pages)
    ├── accessibility  : (Evtest, Xdotool, Chorded hardware mappings)
    ├── power manager  : (PowerTop, TLP predictive governor algorithms)
    ├── customization  : (Pywal dynamic color themes & ricing)
    ├── memory         : (Restic backups, IPFS decentralized archiving)
    └── logs           : (Sysstat performance statistics, Audit logs)
```

### 🖥️ Running the Demo Dashboard

Run the interactive stack dashboard and gap analysis tool:

```bash
# Executable dashboard launcher
./scripts/demo-dashboard.sh

# Or via Nix Flake
nix run .#demo
```

### 🛠️ Entering Declarative Nix Shell Environments

You can instantiate sub-shells for each specific layer or the full stack:

```bash
# Enter full stack shell
nix develop .#default

# Enter individual layer environments
nix develop .#rt    # Runtime & @cmd userland shell
nix develop .#ux    # Userland experience (TUI, GUI, Audio) shell
nix develop .#md    # System domain & specialized modules shell
```

*For a full architectural breakdown and identified gaps, inspect [`STACK_ANALYSIS.md`](./STACK_ANALYSIS.md).*

---

## 🔒 Cryptographic Identity & OpSec

| Protocol / Platform | Identity / Address |
| :--- | :--- |
| **GPG Fingerprint** | `[YOUR_GPG_FINGERPRINT_HERE]` |
| **Matrix** | `@username:matrix.org` |
| **Nostr (npub)** | `npub1...[YOUR_NOSTR_NPUB]` |
| **Primary PGP Key** | `[LINK_OR_KEY_ID]` |
| **Signal / Secure Chat** | `[YOUR_SECURE_HANDLE]` |

---

## 🤖 AI-Augmented Productivity & Modern Workflow

Leveraging next-generation AI tools and agentic workflows to multiply output, accelerate software synthesis, and optimize professional goals:

* **Autonomous Agent Pipelines**: End-to-end task decomposition, automated code generation, refactoring, and test-driven verification.
* **Contextual Knowledge Retrieval**: Utilizing LLMs for rapid synthesis of complex domain literature (Information Theory, Game Theory, Linguistics, System Architecture).
* **AI-Assisted System Architecture**: Rapid prototyping of functional fullstack models, type-safe API boundaries, and low-level system designs.
* **Human-in-the-Loop Governance**: Strict OpSec, verification procedures, and deterministic build validation over AI-generated software artifacts.

---

## 🔬 Hierarchical Research Taxonomy

Research Framework ├── 🧠 Information Theory & Game Theory ├── 🗣️ Linguistics, Phonetics & Assistive Technologies ├── 💻 Functional Programming & Fullstack Integration ├── 📂 World Knowledge Archiving & Category Taxonomy ├── 🌐 Sovereignty, OpSec, Self-Hosting & DeFi ├── ⚡ Multimodal HCI & Hardware Sensing └── 🔋 Predictive Systems Management


<details>
<summary><b>1. 🧠 Information Theory & Game Theory</b></summary>

- Shannon Entropy & Algorithmic Information Theory (AIT)
- Strategic equilibrium models & mechanism design in peer-to-peer networks
- Data compression limits and error-correcting codes
</details>

<details>
<summary><b>2. 🗣️ Linguistics, Phonetics & Assistive Tech</b></summary>

- Phonetic transcription, IPA systems, and speech synthesis models
- Natural language structure, formal grammars, and semantics
- Accessibility frameworks, assistive input mechanisms, and speech-to-intent engines
</details>

<details>
<summary><b>3. 💻 Functional Programming & Fullstack Integration</b></summary>

- Pure functional paradigms, category theory, and strongly typed systems (Rust, Haskell, OCaml, Elixir)
- End-to-end type safety across distributed fullstack architectures
- Immutable state management and declarative system modeling
</details>

<details>
<summary><b>4. 📂 World Knowledge Archiving & Hierarchical Taxonomies</b></summary>

- Systematic indexing and categorization of human knowledge
- Distributed, long-term archival storage formats and metadata standards
- Decoupled, tamper-evident document graphs and knowledge representation
</details>

<details>
<summary><b>5. 🌐 Digital Sovereignty, OpSec, Self-Hosting & DeFi</b></summary>

- Zero-trust architecture, threat modeling, and operational security (OpSec)
- Decentralized finance (DeFi), cryptographic primitives, and smart contract safety
- Sovereign self-hosting infrastructure, mesh networks, and encrypted communication channels
</details>

<details>
<summary><b>6. ⚡ Multimodal HCI, Novel UX & Hardware Sensing</b></summary>

- **Interfacing Modes**: TUIs (Terminal User Interfaces), GUIs, Audio & Speech interactions
- **Input Hardware & Ergonomics**: Azeron keypad mapping, biometric sensors, speech recognition
- **IoT & Telemetry**: Gyroscopic movement pattern analysis across mobile and IoT form factors
- **Interface Personalization**: Ricing, extreme desktop customization, adaptive accessibility layouts
</details>

<details>
<summary><b>7. 🔋 Predictive Systems Management</b></summary>

- Predictive power consumption algorithms for mobile/embedded platforms
- Intelligent storage tiering, cache prediction, and wear-leveling management
- Dynamic resource allocation under energy and hardware constraints
</details>

---

## 🛠️ Open Source Ecosystem & Projects of Interest

| Layer / Domain | Projects & Technologies |
| :--- | :--- |
| **Firmware & Bootstrapping** | [coreboot](https://www.coreboot.org/) • [RISC-V](https://riscv.org/) • [Limine](https://limine-bootloader.org/) • [Booster](https://github.com/anatol/booster) • [Toybox](https://landley.net/toybox/) |
| **OS, Init & System Architecture** | [OpenBSD](https://www.openbsd.org/) • [Skarnet s6 Suite](https://skarnet.org/software/s6/) • [Nix / NixOS](https://nixos.org/) • [ZFS](https://openzfs.org/) |
| **Desktop & Audio/Video Stack** | [Wayland](https://wayland.freedesktop.org/) • [PipeWire](https://pipewire.org/) |
| **Security & Cryptography** | [VeraCrypt](https://www.veracrypt.fr/) • [Ironclad](https://github.com/) |
| **Enterprise Logic & ERP** | [Odoo](https://www.odoo.com/) |

---

## 🛠️ Tech Stack & Tooling

Languages & Paradigms: Rust | Haskell | OCaml | TypeScript | Elixir | C / C++ | Nix Systems & OS: OpenBSD | NixOS | Linux | Skarnet s6 | ZFS UX & Interaction: TUI / Curses | Wayland | PipeWire | Speech Engines | Azeron Security & Privacy: GPG / PGP | VeraCrypt | Matrix | Tor / I2P | WireGuard AI & Automation: Autonomous Agents | LLM Tooling | CI/CD | GitHub Actions


---

## 📊 GitHub Analytics

<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=Saltofthearth&show_icons=true&theme=dark" alt="GitHub Stats" width="48%" />
  <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=Saltofthearth&layout=compact&theme=dark" alt="Top Languages" width="48%" />
</p>

---

<p align="center">
  <sub><i>Designed for sovereign, high-throughput research and autonomous AI-assisted software engineering.</i></sub>
</p>
