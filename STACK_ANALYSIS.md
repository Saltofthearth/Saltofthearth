# 🏛️ Operating System Stack Analysis & Gap Identification

This document provides a comprehensive architectural audit of the Operating System stack based on the defined 3-layer taxonomy: **`@rt`** (Runtime & Hardware Substrate), **`@ux`** (User Experience & HCI), and **`@md`** (Domain & System Management Modules).

Nix is utilized exclusively as the **declarative package manager** and **environment orchestrator** across all three layers.

---

## 📐 Architecture Hierarchy Overview

```
Sovereign OS Taxonomy
├── ⚡ @rt (Runtime / Base System Foundation)
│   ├── 🔌 Boot & Firmware (Limine, Booster, Microcode, Kernel, Drivers)
│   └── 💻 @cmd (Core Userland Execution Environment)
│       ├── shell   : (Bash, Zsh, Nushell)
│       ├── libs    : (Glibc, OpenSSL, Zlib, Ncurses)
│       ├── init    : (Skarnet s6, s6-rc, Execline)
│       ├── fs      : (OpenZFS, Ext4, Btrfs, FAT32)
│       ├── utils   : (Toybox, Coreutils, Util-Linux)
│       └── pkgman  : (Nix Package Manager)
│
├── 🎨 @ux (User Experience & Human-Computer Interaction)
│   ├── tui   : (Ratatui, Curses, Tmux, Htop, Fzf)
│   ├── gui   : (Wayland, Sway, Hyprland, Foot, Mako)
│   └── audio : (PipeWire, WirePlumber, Pavucontrol, ALSA)
│
└── 🧠 @md (Domain & System Management Modules)
    ├── ai             : (Whisper.cpp, Ollama local inference, Speech-to-Intent)
    ├── server         : (WireGuard mesh networking, Matrix decentralized comms)
    ├── system config  : (Home-Manager declarative state, Git)
    ├── manual         : (MdBook documentation engine, Man pages)
    ├── accessibility  : (Evtest, Xdotool, Chorded hardware input mappings)
    ├── power manager  : (PowerTop, TLP predictive governor algorithms)
    ├── customization  : (Pywal dynamic color themes & desktop ricing)
    ├── memory         : (Restic backups, IPFS decentralized archiving)
    └── logs           : (Sysstat performance statistics, Audit logs)
```

---

## 🔍 Detailed Layer Analysis & Gap Identification

### 1. ⚡ Layer `@rt` (Runtime / Base System Foundation)

#### `@rt` Boot, Hardware & Kernel
* **Current Components**: Limine bootloader, Booster initramfs generator, Glibc, kernel utilities.
* **Status**: Highly functional modular boot foundation.
* **Identified Gaps & Missing Pieces**:
  1. **Coreboot / UEFI Integration Glue**: While Limine handles multiboot, automated firmware payload generation for Coreboot targets requires standard Nix derivations.
  2. **Microcode Auto-Detection**: Intel/AMD CPU microcode update hooks in initramfs generation need explicit declarative binding.

#### `@rt/@cmd` (Core Userland Execution Environment)
* **Submodules**:
  * `shell`: Bash, Zsh, Nushell present.
  * `libs`: C standard library (glibc), OpenSSL, zlib.
  * `init`: Skarnet `s6` suite, `s6-rc`, `execline`.
  * `fs`: `zfs`, `e2fsprogs`, `btrfs-progs`.
  * `utils`: `toybox`, `coreutils`, `util-linux`.
  * `pkgman`: `nix`, `nvd`, `nix-output-monitor`.
* **Identified Gaps & Missing Pieces**:
  1. **s6 Service Supervision Tree Templates**: While `s6` binaries are installed, pre-packaged declarative service directory definitions (`/etc/s6/services` templates) are needed for pure non-systemd userland init.
  2. **ZFS Boot-Environment Integration**: Automated ZFS snapshot-on-build scripts (`zfs-auto-snapshot` hooks) to ensure instant rollback on declarative updates.

---

### 2. 🎨 Layer `@ux` (User Experience & HCI)

#### Submodules: `tui`, `gui`, `audio`
* **Current Components**:
  * `tui`: Tmux, Htop, Fzf, Ratatui environment support.
  * `gui`: Sway, Hyprland (Wayland compositors), Foot terminal, Mako notification daemon.
  * `audio`: PipeWire, WirePlumber, Pavucontrol.
* **Status**: Modern, minimal, high-throughput Wayland & TUI stack.
* **Identified Gaps & Missing Pieces**:
  1. **Multimodal Speech-to-Intent Daemon**: Connection between PipeWire audio streams and `whisper.cpp` inference engine for low-latency voice command execution.
  2. **Azeron Keypad Driver Mapping**: Custom input abstraction layer for chorded keypads (Azeron) to map analog thumbstick movements to Wayland window management.

---

### 3. 🧠 Layer `@md` (Domain & System Management)

#### Submodules: `ai`, `server`, `system config`, `manual`, `accessibility`, `power manager`, `customization`, `memory`, `logs`
* **Current Components**:
  * `ai`: `whisper-cpp`, `ollama`.
  * `server`: `wireguard-tools`, `matrix-synapse`.
  * `system config`: `home-manager`, `git`.
  * `manual`: `mdbook`, `man-pages`.
  * `accessibility`: `evtest`, `xdotool`.
  * `power manager`: `powertop`, `tlp`.
  * `customization`: `pywal`.
  * `memory`: `restic`, `ipfs`.
  * `logs`: `sysstat`, process monitors.
* **Status**: Broad coverage of sovereign, self-hosted, and predictive capabilities.
* **Identified Gaps & Missing Pieces**:
  1. **Predictive Storage & Memory Tiering**: Dynamic SSD/NVMe cache prediction algorithms to optimize wear-leveling and cold-storage offloading to IPFS/ZFS.
  2. **Unified Taxonomy Classifier**: Automated tool to parse system logs, documentation (`.md`), and research taxonomy (`TAXONOMY.md`) into a searchable semantic graph.

---

## 🎯 Priority Matrix & Summary of Recommended Enhancements

All enhancements are aligned with the repository's **Hierarchy of Priority Work** *(see [`ROADMAP.md`](./ROADMAP.md))*:

| Pillar | Priority Level | Component | Enhancement Description |
| :--- | :--- | :--- | :--- |
| **Pillar 1: Repo Architecture** | High (P1) | `@rt/@cmd/init` | Provide `s6` declarative service definition templates for non-systemd init. |
| **Pillar 1: Repo Architecture** | High (P1) | `@rt/@cmd/fs` | Implement ZFS snapshot integration on Nix generation switches. |
| **Pillar 1: Repo Architecture** | High (P1) | Infrastructure | OpenTofu module validation and zero-cost cloud allocation testing. |
| **Pillar 2: AI Automation** | Medium (P2) | `@ux/audio` + `@md/ai` | Build PipeWire -> Speech-to-Intent CLI bridge script with `whisper.cpp`. |
| **Pillar 2: AI Automation** | Medium (P2) | AI Router | Finalize LiteLLM multi-provider zero-cost failover routing proxy. |
| **Pillar 2: AI Automation** | Low (P2) | `@ux/gui` | Map Azeron analog input bindings for Wayland tiling compositors. |

---

*Document compiled as part of the Sovereign OS Nix Declarative Stack Demonstration.*
