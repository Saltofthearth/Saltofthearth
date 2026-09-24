#!/usr/bin/env bash
# Sovereign OS - TUI Stack Status Dashboard & Demo Launcher
# Evaluates and visualizes the system stack hierarchy: @rt (@cmd), @ux, @md

set -euo pipefail

# ANSI Color Codes
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"
MAGENTA="\033[35m"
RESET="\033[0m"

check_binary() {
    local bin="$1"
    if command -v "$bin" >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Present${RESET} ($(command -v "$bin"))"
    else
        echo -e "${YELLOW}○ Declarative in Nix taxonomy${RESET}"
    fi
}

print_header() {
    clear || true
    echo -e "${BOLD}${CYAN}========================================================================${RESET}"
    echo -e "${BOLD}${CYAN}   🚀 SOVEREIGN OS TAXONOMY STACK DEMO & ENVIRONMENT DASHBOARD         ${RESET}"
    echo -e "${BOLD}${CYAN}========================================================================${RESET}"
    echo -e "${BOLD}Declarative Package Management: Nix${RESET}"
    echo -e "${BOLD}Architecture Hierarchy: @rt (boot, @cmd), @ux (tui, gui, audio), @md (ai, server, system config, etc.)${RESET}"
    echo -e "${CYAN}------------------------------------------------------------------------${RESET}\n"
}

show_rt_layer() {
    echo -e "${BOLD}${MAGENTA}⚡ LAYER 1: @rt (Runtime & Hardware Substrate)${RESET}"
    echo -e "${BOLD}  🔌 Boot, Drivers & Kernel Substrate:${RESET}"
    echo -e "    • Bootloader        : Limine Multi-boot ${GREEN}(Configured in nix/rt/boot.nix)${RESET}"
    echo -e "    • Initramfs         : Booster ${GREEN}(Configured in nix/rt/boot.nix)${RESET}"
    echo -e "    • Kernel Modules    : kmod $(check_binary kmod)"
    echo -e "    • PCI/USB Inspection: pciutils $(check_binary lspci), usbutils $(check_binary lsusb)"
    echo ""
    echo -e "${BOLD}  💻 @cmd (Core Userland Execution Environment):${RESET}"
    echo -e "    • Shells            : bash $(check_binary bash), zsh $(check_binary zsh), nushell $(check_binary nu)"
    echo -e "    • Core Libraries    : glibc, openssl, zlib, ncurses"
    echo -e "    • Init & Supervision: Skarnet s6 $(check_binary s6-svscan), s6-rc $(check_binary s6-rc), execline"
    echo -e "    • Filesystems       : OpenZFS $(check_binary zfs), e2fsprogs $(check_binary tune2fs), btrfs $(check_binary btrfs)"
    echo -e "    • Utilities         : toybox $(check_binary toybox), coreutils $(check_binary ls), util-linux"
    echo -e "    • Package Manager   : Nix $(check_binary nix)"
    echo -e "${CYAN}------------------------------------------------------------------------${RESET}\n"
}

show_ux_layer() {
    echo -e "${BOLD}${BLUE}🎨 LAYER 2: @ux (User Experience & HCI)${RESET}"
    echo -e "  • ${BOLD}TUI (Terminal UI)${RESET}    : ratatui, tmux $(check_binary tmux), htop $(check_binary htop), fzf $(check_binary fzf)"
    echo -e "  • ${BOLD}GUI (Wayland UI)${RESET}   : sway $(check_binary sway), hyprland $(check_binary hyprland), foot $(check_binary foot)"
    echo -e "  • ${BOLD}Audio Stack${RESET}        : pipewire $(check_binary pipewire), wireplumber $(check_binary wireplumber), pavucontrol"
    echo -e "${CYAN}------------------------------------------------------------------------${RESET}\n"
}

show_md_layer() {
    echo -e "${BOLD}${YELLOW}🧠 LAYER 3: @md (Domain & System Management Modules)${RESET}"
    echo -e "  • ${BOLD}AI & Speech${RESET}        : whisper.cpp $(check_binary whisper-cpp), ollama $(check_binary ollama)"
    echo -e "  • ${BOLD}Server & Comms${RESET}     : wireguard $(check_binary wg), matrix-synapse"
    echo -e "  • ${BOLD}System Config${RESET}      : home-manager $(check_binary home-manager), git $(check_binary git)"
    echo -e "  • ${BOLD}Documentation${RESET}      : mdbook $(check_binary mdbook), man-pages"
    echo -e "  • ${BOLD}Accessibility${RESET}      : evtest $(check_binary evtest), xdotool $(check_binary xdotool)"
    echo -e "  • ${BOLD}Power Manager${RESET}      : powertop $(check_binary powertop), tlp $(check_binary tlp)"
    echo -e "  • ${BOLD}Customization${RESET}      : pywal $(check_binary wal)"
    echo -e "  • ${BOLD}Memory & Storage${RESET}   : restic $(check_binary restic), ipfs $(check_binary ipfs)"
    echo -e "  • ${BOLD}Telemetry & Logs${RESET}    : sysstat $(check_binary sar), htop"
    echo -e "${CYAN}------------------------------------------------------------------------${RESET}\n"
}

show_priority_hierarchy() {
    echo -e "${BOLD}${MAGENTA}🎯 HIERARCHY OF PRIORITY WORK (ROADMAP):${RESET}"
    echo -e "  ${BOLD}🏛️ PRIORITY #1: Repository Architecture (Core Substrate & Systems)${RESET}"
    echo -e "    • ${BOLD}[@rt/@cmd/init]${RESET} Declarative s6 supervision service directory tree templates."
    echo -e "    • ${BOLD}[@rt/@cmd/fs]${RESET}   Automated ZFS snapshot-on-build hooks for instant environment rollback."
    echo -e "    • ${BOLD}[Infrastructure]${RESET} OpenTofu zero-cost cloud allocation & quota scheduler validation."
    echo ""
    echo -e "  ${BOLD}🤖 PRIORITY #2: AI Automation (Zero-Cost Sovereign AI Stack & Workflows)${RESET}"
    echo -e "    • ${BOLD}[AI Router]${RESET}     LiteLLM zero-cost multi-provider router (Groq/Cerebras/Gemini/Ollama)."
    echo -e "    • ${BOLD}[Agentic Work]${RESET}  Jules continuous integration, deep planning & pre-commit validation."
    echo -e "    • ${BOLD}[@ux/audio+ai]${RESET} PipeWire audio stream -> Whisper.cpp speech-to-intent bridge."
    echo -e "    • ${BOLD}[@ux/gui+acc]${RESET}  Azeron chorded keypad analog driver abstraction for Wayland compositors."
    echo -e "${CYAN}------------------------------------------------------------------------${RESET}\n"
}

main() {
    print_header
    show_rt_layer
    show_ux_layer
    show_md_layer
    show_priority_hierarchy
    echo -e "${BOLD}To inspect or build specific shells via Nix:${RESET}"
    echo -e "  • Full Stack Shell : ${GREEN}nix develop .#default${RESET}"
    echo -e "  • @rt Layer Shell  : ${GREEN}nix develop .#rt${RESET}"
    echo -e "  • @ux Layer Shell  : ${GREEN}nix develop .#ux${RESET}"
    echo -e "  • @md Layer Shell  : ${GREEN}nix develop .#md${RESET}"
    echo -e "\n${BOLD}See STACK_ANALYSIS.md for full gap analysis and details.${RESET}"
}

main "$@"
