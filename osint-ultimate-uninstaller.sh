#!/bin/bash

###############################################################################
# 🗑  OSINT ULTIMATE UNINSTALLER
# 
# Removes:
#   ✓ All installed OSINT tools (Python packages)
#   ✓ Cloned git repos
#   ✓ Downloaded binaries (phoneinfoga, massdns)
#   ✓ Go binaries from go-bin/
#   ✓ Configuration files (.env, .webhooks)
#   ✓ Logs and history
#   ✓ WebUI files (Python, HTML, SSL, DB)
#   ✓ Optional: Docker stack (containers, images, volumes)
#
# Usage:
#   ./osint-uninstall.sh                  # Interactive menu (default)
#   ./osint-uninstall.sh --full           # Full uninstall (no Docker)
#   ./osint-uninstall.sh --all            # Full uninstall + Docker
#   ./osint-uninstall.sh --keep-config    # Uninstall but keep API keys
#   ./osint-uninstall.sh --docker-only    # Only remove Docker stack
#   ./osint-uninstall.sh --help           # Show help
###############################################################################

set -u

# ====================== COLORS ======================
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; PURPLE='\033[0;35m'; CYAN='\033[0;36m'
NC='\033[0m'; BOLD='\033[1m'

# ====================== CONFIG ======================
INSTALL_DIR="$HOME/osint-suite"
PYTHON_DIR="$INSTALL_DIR/python"
GO_BIN_DIR="$INSTALL_DIR/go-bin"
BIN_DIR="$INSTALL_DIR/bin"
DATA_DIR="$INSTALL_DIR/data"
CONFIG_DIR="$INSTALL_DIR/config"
LOGS_DIR="$INSTALL_DIR/logs"
DOCKER_DIR="$INSTALL_DIR/docker"
WEBUI_DIR="$INSTALL_DIR/webui"
TEMPLATES_DIR="$WEBUI_DIR/templates"
STATIC_DIR="$WEBUI_DIR/static"
SSL_DIR="$WEBUI_DIR/ssl"
SQLITE_DIR="$WEBUI_DIR/db"
SW_DIR="$WEBUI_DIR/service-worker"
ENV_FILE="$CONFIG_DIR/.env"
ENV_TEMPLATE="$CONFIG_DIR/.env.template"
WEBHOOK_FILE="$CONFIG_DIR/.webhooks"
TOOLS_FILE="$INSTALL_DIR/installed_tools.txt"
CREDS_FILE="$WEBUI_DIR/.credentials"
IP_WHITELIST_FILE="$WEBUI_DIR/.ip_whitelist"
HISTORY_DB="$SQLITE_DIR/history.db"

# ====================== HELPERS ======================
banner() { clear; echo -e "${RED}${BOLD}"
cat << 'EOF'
╔═══════════════════════════════════════════════════════════════════════╗
║     🗑  ██�   ██╗███╗   ██╗██╗███╗   ██╗███████╗████████╗         ║
�         ██║   ██║████╗  ██�██║████╗  ██║██╔════╝╚══██╔══╝         ║
║         ██║   ██║██╔██╗ ██║██║██╔██╗ ██║███████╗   ██║            ║
�         ██║   ██║██║╚██�██║██║██║╚██╗██║╚════██║   ██║            ║
║         ╚██████╔�██║ ╚████║██║██║ ╚████║███████║   ██║            ║
║          ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝  UNINSTALL║
╚═══════════════════════════════════════════════════════════════════════�
EOF
echo -e "${NC}"; }
pause() { echo ""; read -rp "$(echo -e "${CYAN}⏎ Press Enter...${NC}")"; }
confirm() {
    local msg="${1:-Are you sure?}"
    echo -e "${YELLOW}${msg} (y/n):${NC}"
    read -rp "" yn
    [[ "$yn"ls =~ ^[Yy]$ ]]
}

# ====================== UNINSTALL FUNCTIONS ======================

uninstall_python_tools() {
    banner
    echo -e "${BLUE}[*] Removing Python packages...${NC}\
n"
    
    if [ ! -f "$TOOLS_FILE" ]; then
        echo -e "${YELLOW}No installed_tools.txt found.${NC}"
        return
    fi
    
    local count=0
    while IFS= read -r tool; do
        [ -z "$tool" ] && continue
        # Map common names to pip packages
        local pkg="$tool"
        case "$tool" in
            sherlock) pkg="sherlock-project" ;;
            
phoneinfoga|metagoofil|recon-ng|spiderfoot|dnstwist|osintgram|tinfoleak|linkedin2usphoneinfoga|metagoofil|recon-ng|spiderfoot|dnstwist|osintgram|tinfoleaklinkedin2username|whapa|namechk|blackbird|crosslinked|simplyemail|mosint|leaklooker|pwndb|scyllrname|whapa|namechk|blackbird|crosslinked|simplyemail|mosint|leaklooker|pwndb|scylla|leakpeek|breach-parse|ditto|mrholmes|cewl|cewl-fab|cupp|mentalist|bug-hunter|bb-to|leakpeek|breach-parse|ditto|mrholmes|cewl|cewl-fab|cupp|mentalist|bug-hunter|bb-toolkit|recsech|lazyrecon|reconness|gitminer|gitrecon|cloudflair|s3scanner|xsstrike|bulkit|recsech|lazyrecon|reconness|gitminer|gitrecon|cloudflair|s3scanner|xsstrike|bug-hunter|bughunter|web-analyze|webanalyze|finalrecon|photon|url-extractor|reconspide-hunter|bughunter|web-analyze|webanalyze|finalrecon|photon|url-extractor|reconspider|datasploit|harpoon|omninyx|ip-tracer|seeker|geo-recon|geocreepy|wigle|twayback|eml|datasploit|harpoon|omninyx|ip-tracer|seeker|geo-recon|geocreepy|wigle|twayback|eml-analyzer|darkscrape|torbot|onioff|onionsearch|testssl.sh|hostintel|eml-analyzer) 
pkg="" ;;  # Git-cloned, skip pip
        esac
        
        if [ -n "$pkg" ]; then
            echo -e "  ${CYAN}→ pip uninstall: $pkg${NC}"
            pip3 uninstall -y "$pkg" 2>/dev/null && echo -e "    ${GREEN}[✓] 
Removed${NC}" || echo -e "    ${YELLOW}[~] Skipped (not installed via pip)${NC}"
            ((count++))
        fi
    done < "$TOOLS_FILE"
    
    echo -e "\n${GREEN}[✓] Processed $count Python packages${NC}"
    pause
}

remove_cloned_repos() {
    banner
    echo -e "${BLUE}[*] Removing cloned git repositories...${NC}\n"
    
    local count=0
    for dir in "$PYTHON_DIR"/*/ "$DATA_DIR"/*/; do
        [ -d "$dir" ] || continue
        local name=$(basename "$dir")
        echo -e "  ${CYAN}→ rm -rf $name${NC}"
        rm -rf "$dir" && ((count++))
    done
    
    echo -e "\n${GREEN}[✓] Removed $count directories${NC}"
    pause
}

remove_go_binaries() {
    banner
    echo -e "${BLUE}[*] Removing Go binaries...${NC}\n"
    
    if [ ! -d "$GO_BIN_DIR" ]; then
        echo -e "${YELLOW}No go-bin directory.${NC}"
        return
    fi
    
    local count=0
    for binary in "$GO_BIN_DIR"/*; do
        [ -f "$binary" ] || continue
        local name=$(basename "$binary")
        echo -e "  ${CYAN}→ rm $name${NC}"
        rm -f "$binary" && ((count++))
        # Also remove from ~/.go/bin if symlinked
        [ -f "$HOME/go/bin/$name" ] && rm -f "$HOME/go/bin/$name"
    done
    
    echo -e "\n${GREEN}[✓] Removed $count Go binaries${NC}"
    pause
}

remove_downloaded_binaries() {
    banner
    echo -e "${BLUE}[*] Removing downloaded binaries...${NC}\n"
    
    if [ -f "/usr/local/bin/phoneinfoga" ]; then
        echo -e "  ${CYAN}→ rm /usr/local/bin/phoneinfoga${NC}"
        sudo rm -f /usr/local/bin/phoneinfoga 2>/dev/null
    fi
    
    if [ -f "/usr/local/bin/massdns" ]; then
        echo -e "  ${CYAN}→ rm /usr/local/bin/massdns${NC}"
        sudo rm -f /usr/local/bin/massdns 2>/dev/null
    fi
    
    if [ -d "$BIN_DIR" ]; then
        local count=0
        for binary in "$BIN_DIR"/*; do
            [ -f "$binary" ] || continue
            echo -e "  ${CYAN}→ rm $(basename $binary)${NC}"
            rm -f "$binary" && ((count++))
        done
        echo -e "${GREEN}[✓] Removed $count binaries from $BIN_DIR${NC}"
    fi
    
    pause
}

remove_config_files() {
    banner
    echo -e "${BLUE}[*] Removing configuration files...${NC}\n"
    
    local files=(
        "$ENV_FILE"
        "$ENV_TEMPLATE"
        "$WEBHOOK_FILE"
        "$TOOLS_FILE"
        "$CREDS_FILE"
        "$IP_WHITELIST_FILE"
        "$HISTORY_DB"
    )
    
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo -e "  ${CYAN}→ rm $(basename $file)${NC}"
            rm -f "$file"
        fi
    done
    
    echo -e "\n${GREEN}[✓] Config files removed${NC}"
    pause
}

remove_logs() {
    banner
    echo -e "${BLUE}[*] Removing logs...${NC}\n"
    
    if [ -d "$LOGS_DIR" ]; then
        local count=$(find "$LOGS_DIR" -type f | wc -l)
        rm -rf "$LOGS_DIR"
        echo -e "  ${GREEN}[✓] Removed $count log files${NC}"
    else
        echo -e "${YELLOW}No logs directory.${NC}"
    fi
    
    pause
}

remove_webui() {
    banner
    echo -e "${BLUE}[*] Removing WebUI files...${NC}\n"
    
    if [ -d "$WEBUI_DIR" ]; then
        echo -e "  ${CYAN}→ rm -rf $WEBUI_DIR${NC}"
        rm -rf "$WEBUI_DIR"
        echo -e "  ${GREEN}[✓] WebUI completely removed${NC}"
        echo -e "  ${CYAN}  (HTML templates, Python server, SSL certs, SQLite 
DB)${NC}"
    else
        echo -e "${YELLOW}No WebUI directory.${NC}"
    fi
    
    pause
}

remove_docker_stack() {
    banner
    echo -e "${PURPLE}${BOLD}━━━ 🐳 DOCKER STACK UNINSTALL ━━━${NC}\n"
    echo -e "${YELLOW}This will remove:${NC}"
    echo "  • All containers (spiderfoot, recon-ng, tor, grafana, prometheus, 
etc.)"
    echo "  • All images (osint-*, grafana/grafana, prom/prometheus, postgres, 
etc.)"
    echo "  • All volumes (postgres data, elasticsearch data, tor data, grafana 
data)"
    echo "  • All networks (osint-net)"
    echo "  • Docker Compose files"
    echo ""
    
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}[!] Docker not installed.${NC}"
        pause
        return
    fi
    
    if ! confirm "🗑  Remove DOCKER stack (containers + images + volumes)?"; then
        echo -e "${YELLOW}[~] Skipped Docker removal${NC}"
        return
    fi
    
    echo ""
    
    # Stop containers
    if [ -d "$DOCKER_DIR" ] && [ -f "$DOCKER_DIR/docker-compose.yml" ]; then
        echo -e "${BLUE}[*] Stopping containers...${NC}"
        cd "$DOCKER_DIR"
        docker compose --env-file "$ENV_FILE" down 2>/dev/null || docker compose 
down 2>/dev/null
        cd - > /dev/null
        echo -e "${GREEN}[✓] Containers stopped${NC}"
    fi
    
    # Remove containers
    echo -e "${BLUE}[*] Removing containers...${NC}"
    local containers=$(docker ps -a --filter "name=osint-" -q 2>/dev/null)
    if [ -n "$containers" ]; then
        docker rm -f $containers 2>/dev/null
        echo -e "${GREEN}[✓] Removed OSINT containers${NC}"
    else
        echo -e "${YELLOW}[~] No OSINT containers found${NC}"
    fi
    
    # Remove images
    echo -e "${BLUE}[*] Removing images...${NC}"
    local images=$(docker images --filter "reference=osint-*" -q 2>/dev/null)
    [ -n "$images" ] && docker rmi -f $images 2>/dev/null
    echo -e "${GREEN}[✓] Removed custom OSINT images${NC}"
    
    # Remove volumes
    echo -e "${BLUE}[*] Removing volumes...${NC}"
    local volumes=$(docker volume ls --filter "name=osint" -q 2>/dev/null)
    [ -n "$volumes" ] && docker volume rm $volumes 2>/dev/null
    echo -e "${GREEN}[✓] Removed OSINT volumes${NC}"
    
    # Remove network
    echo -e "${BLUE}[*] Removing network...${NC}"
    docker network rm osint-net 2>/dev/null
    echo -e "${GREEN}[✓] Removed osint-net network${NC}"
    
    # Remove Docker files
    echo -e "${BLUE}[*] Removing Docker Compose files...${NC}"
    if [ -d "$DOCKER_DIR" ]; then
        rm -rf "$DOCKER_DIR"
        echo -e "${GREEN}[✓] Removed $DOCKER_DIR${NC}"
    fi
    
    # Optional: Full Docker system prune
    echo ""
    if confirm "🧹 Also run 'docker system prune' (removes ALL dangling Docker 
resources)?"; then
        docker system prune -f 2>/dev/null
        echo -e "${GREEN}[✓] Docker system pruned${NC}"
    fi
    
    pause
}

nuclear_option() {
    banner
    echo -e "${RED}${BOLD}━━━ ☢  NUCLEAR OPTION ☢  ━━━${NC}\n"
    echo -e "${RED}This will COMPLETELY REMOVE everything:${NC}"
    echo -e "  ${RED}✗${NC} All OSINT tools (Python packages, Go binaries)"
    echo -e "  ${RED}✗${NC} All cloned repos"
    echo -e "  ${RED}✗${NC} All configurations and API keys"
    echo -e "  ${RED}✗${NC} All logs and history"
    echo -e "  ${RED}✗${NC} WebUI (HTML, Python, SSL, DB)"
    echo -e "  ${RED}✗${NC} Docker stack (containers, images, volumes)"
    echo -e "  ${RED}✗${NC} The entire ~/osint-suite/ directory"
    echo ""
    echo -e "${YELLOW}⚠  This cannot be undone!${NC}"
    echo ""
    
    if ! confirm "🔥 Are you ABSOLUTELY sure? Type 'y' to proceed"; then
        echo -e "${YELLOW}[~] Cancelled${NC}"
        return
    fi
    
    echo ""
    
    # Remove Docker first (if exists)
    if [ -d "$DOCKER_DIR" ] && command -v docker &> /dev/null; then
        echo -e "${BLUE}[*] Removing Docker stack...${NC}"
        cd "$DOCKER_DIR"
        docker compose --env-file "$ENV_FILE" down -v 2>/dev/null || docker 
compose down -v 2>/dev/null
        docker ps -a --filter "name=osint-" -q 2>/dev/null | xargs -r docker rm -f 
2>/dev/null
        docker images --filter "reference=osint-*" -q 2>/dev/null | xargs -r 
docker rmi -f 2>/dev/null
        docker volume ls --filter "name=osint" -q 2>/dev/null | xargs -r docker 
volume rm 2>/dev/null
        docker network rm osint-net 2>/dev/null
        cd - > /dev/null
    fi
    
    # Nuke the entire directory
    echo -e "${BLUE}[*] Removing ~/osint-suite/...${NC}"
    rm -rf "$INSTALL_DIR"
    
    # Clean up PATH additions from .bashrc
    if grep -q "osint-suite/source_me.sh" "$HOME/.bashrc" 2>/dev/null; then
        echo -e "${BLUE}[*] Cleaning .bashrc...${NC}"
        sed -i '/osint-suite\/source_me.sh/d' "$HOME/.bashrc"
 echo -e "${GREEN}[✓] .bashrc cleaned${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}${BOLD}✅ NUCLEAR OPTION COMPLETE${NC}"
    echo -e "${GREEN}All traces of OSINT Suite removed.${NC}"
    pause
    exit 0
}

partial_uninstall() {
    banner
    echo -e "${CYAN}${BOLD}━━━ � SELECTIVE UNINSTALL ━━━${NC}\n"
    echo "Choose what to remove:"
    echo ""
    echo "  1) Python packages only"
    echo "  2) Cloned git repos only"
    echo "  3) Go binaries only"
    echo "  4) Downloaded binaries (phoneinfoga, massdns)"
    echo "  5) Configuration files (.env, .webhooks)"
    echo "  6) Logs only"
    echo "  7) WebUI only"
    echo "  8) Docker stack only (optional Docker)"
    echo "  9) Everything except Docker"
    echo "  10) Everything including Docker"
    echo ""
    echo "  0) ← Back"
    read -rp "$(echo -e ${YELLOW}"Select [0-10]: "${NC})" opt
    
    case $opt in
        1) uninstall_python_tools ;;
        2) remove_cloned_repos ;;
        3) remove_go_binaries ;;
        4) remove_downloaded_binaries ;;
        5) remove_config_files ;;
        6) remove_logs ;;
        7) remove_webui ;;
        8) remove_docker_stack ;;
        9) uninstall_full_no_docker ;;
        10) uninstall_full_with_docker ;;
        0) return ;;
    esac
}

uninstall_full_no_docker() {
    banner
    echo -e "${YELLOW}${BOLD}━━━ 📦 FULL UNINSTALL (NO DOCKER) ━━━${NC}\n"
    echo "This will remove:"
    echo "  • Python packages"
    echo "  • Cloned repos"
    echo "  • Go binaries"
    echo "  • Downloaded binaries"
    echo "  • Config files"
    echo "  • Logs"
    echo "  • WebUI"
    echo ""
    echo -e "${CYAN}Docker stack will NOT be touched (if you have it)${NC}"
    echo ""
    
    if ! confirm "Proceed with full uninstall (excluding Docker)?"; then
        return
    fi
    
    uninstall_python_tools
    remove_cloned_repos
    remove_go_binaries
    remove_downloaded_binaries
    remove_config_files
    remove_logs
    remove_webui
    
    # Clean .bashrc
    if grep -q "osint-suite/source_me.sh" "$HOME/.bashrc" 2>/dev/null; then
        sed -i '/osint-suite\/source_me.sh/d' "$HOME/.bashrc"
    fi
    
    echo -e "\n${GREEN}${BOLD}✅ Full uninstall (no Docker) complete!${NC}"
    echo -e "${CYAN}Docker stack remains intact. Use option 8 to remove it.${NC}"
    pause
}

uninstall_full_with_docker() {
    banner
    echo -e "${RED}${BOLD}━━━ 🗑 FULL UNINSTALL + DOCKER ━━━${NC}\n"
    echo "This will remove:"
    echo "  • ALL Python packages, repos, binaries"
    echo "  • Config, logs, WebUI"
    echo "  • Docker stack (containers, images, volumes, networks)"
    echo ""
    
    if ! confirm "Proceed with COMPLETE uninstall including Docker?"; then
        return
    fi
    
    uninstall_python_tools
    remove_cloned_repos
    remove_go_binaries
    remove_downloaded_binaries
    remove_config_files
    remove_logs
    remove_webui
    remove_docker_stack
    
    # Clean .bashrc
    if grep -q "osint-suite/source_me.sh" "$HOME/.bashrc" 2>/dev/null; then
        sed -i '/osint-suite\/source_me.sh/d' "$HOME/.bashrc"
    fi
    
    echo -e "\n${RED}${BOLD}✅ COMPLETE uninstall finished!${NC}"
    echo -e "${YELLOW}Everything has been removed.${NC}"
    pause
}

show_status() {
    banner
    echo -e "${CYAN}${BOLD}━━━ 📊 CURRENT INSTALLATION STATUS ━━━${NC}\n"
    
    echo -e "${BLUE}📁 Directory structure:${NC}"
    if [ -d "$INSTALL_DIR" ]; then
        du -sh "$INSTALL_DIR"/*/ 2>/dev/null | head -20
    else
        echo -e "  ${RED}~/osint-suite does not exist${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}📦 Tracked tools:${NC} $(wc -l < "$TOOLS_FILE" 2>/dev/null || 
echo 0)"
    
    echo ""
    echo -e "${BLUE}🐳 Docker status:${NC}"
    if command -v docker &> /dev/null; then
        local running=$(docker ps --filter "name=osint-" -q 2>/dev/null | wc -l)
        local total=$(docker ps -a --filter "name=osint-" -q 2>/dev/null | wc -l)
        local images=$(docker images --filter "reference=osint-*" -q 2>/dev/null | 
wc -l)
        local volumes=$(docker volume ls --filter "name=osint" -q 2>/dev/null | wc 
-l)
        echo "  Running containers: $running / $total"
        echo "  Custom images: $images"
        echo "  Volumes: $volumes"
    else
        echo -e "  ${YELLOW}Docker not installed${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}💾 Disk usage:${NC}"
    if [ -d "$INSTALL_DIR" ]; then
        du -sh "$INSTALL_DIR" 2>/dev/null
    fi
    
    pause
}

# ====================== MAIN MENU ======================
main_menu() {
    while true; do
        banner
        echo -e "${BOLD}${CYAN}━━━ OSINT UNINSTALLER ━━━${NC}\n"
        
        if [ ! -d "$INSTALL_DIR" ]; then
            echo -e "${YELLOW}No installation detected at $INSTALL_DIR${NC}"
            echo ""
            read -rp "Exit? (y/n): " yn
            [[ "$yn" =~ ^[Yy]$ ]] && exit 0
        fi
        
        echo -e "  ${YELLOW} 1${NC}  🎯 Selective uninstall (pick what to remove)"
        echo -e "  ${YELLOW} 2${NC}  � Full uninstall (${GREEN}NO Docker${NC}) — 
recommended"
        echo -e "  ${YELLOW} 3${NC}  🗑 Full uninstall ${RED}+ Docker${NC} 
(everything)"
        echo -e "  ${YELLOW} 4${NC}  🐳 Docker stack ${RED}only${NC}"
        echo -e "  ${YELLOW} 5${NC}  ☢  ${RED}Nuclear option${NC} (nuke 
everything)"
        echo -e "  ${CYAN} 6${NC}  📊 Show current installation status"
        echo ""
        echo -e "  ${RED} 0${NC}  🚪 Exit"
        echo ""
        read -rp "$(echo -e ${BOLD}${YELLOW}"Select [0-6]: "${NC})" c
        case $c in
            1) partial_uninstall ;;
            2) uninstall_full_no_docker ;;
            3) uninstall_full_with_docker ;;
            4) remove_docker_stack ;;
            5) nuclear_option ;;
            6) show_status ;;
            0)
                banner
                echo -e "${GREEN}👋 Goodbye.${NC}"
                exit 0 ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}

# ====================== CLI DISPATCH ======================
trap 'echo -e "\n${RED}Interrupted${NC}"; exit 1' INT

case "${1:-}" in
    --full) uninstall_full_no_docker ;;
    --all) uninstall_full_with_docker ;;
    --keep-config)
        # Uninstall but keep API keys
        banner
        echo -e "${CYAN}Uninstalling but keeping .env file...${NC}"
        if [ -f "$ENV_FILE" ]; then
            cp "$ENV_FILE" "$HOME/.osint_env_backup"
            echo -e "${GREEN}[✓] Backup: $HOME/.osint_env_backup${NC}"
        fi
        uninstall_full_no_docker ;;
    --docker-only) remove_docker_stack ;;
    --status) show_status ;;
    --help|-h)
        cat << 'EOF'
🗑  OSINT Ultimate Uninstaller

Usage:
  ./osint-uninstall.sh                  # Interactive menu (default)
  ./osint-uninstall.sh --full           # Full uninstall (excludes Docker)
  ./osint-uninstall.sh --all            # Full uninstall + Docker
  ./osint-uninstall.sh --keep-config    # Uninstall but keep API keys
  ./osint-uninstall.sh --docker-only    # Only remove Docker stack
  ./osint-uninstall.sh --status         # Show current status
  ./osint-uninstall.sh --help           # Show this help

Uninstall Modes:
  • Selective   - Pick exactly what to remove
  • Full        - Everything except Docker (safe default)
  • Full+Docker - Everything including Docker stack
  • Docker-only - Just the containers/images/volumes
  • Nuclear     - rm -rf ~/osint-suite (no questions)

Docker is OPTIONAL in all modes except --all and Docker-only.
EOF
        ;;
    "") main_menu ;;
    *)
        echo "Unknown arg: $1"
        echo "Run: $0 --help"
        exit 1
        ;;
esac
```

## 🚀 Usage

```bash
# Save
nano ~/osint-uninstall.sh
# Paste, Ctrl+X, Y, Enter

# Make executable
chmod +x ~/osint-uninstall.sh

# Interactive menu (recommended)
~/osint-uninstall.sh

# Quick full uninstall (no Docker)
~/osint-uninstall.sh --full

# Full uninstall including Docker
~/osint-uninstall.sh --all

# Keep API keys during uninstall
~/osint-uninstall.sh --keep-config

# Only remove Docker stack
~/osint-uninstall.sh --docker-only

# Show what's currently installed
~/osint-uninstall.sh --status

# Help
~/osint-uninstall.sh --help
```

## 📊 Uninstall Options

| Mode | Command | Description |
|------|---------|-------------|
| 🎯 **Selective** | `1` in menu | Pick exactly what to remove |
| 📦 **Full (no Docker)** | `--full` | Everything except Docker stack |
| 🗑 **Full + Docker** | `--all` | Everything including Docker |
| 🐳 **Docker only** | `--docker-only` | Just containers/images/volumes |
| ☢ **Nuclear** | `5` in menu | `rm -rf ~/osint-suite/` (no questions) |
| 📊 **Status** | `--status` | Show current installation |

## 🐳 Docker Removal Details

When Docker uninstall is selected, it removes:

| Component | Action |
|-----------|--------|
| 🛑 **Containers** | Stop & remove all `osint-*` containers |
| 🖼 **Images** | Remove custom `osint-*` images |
| 💾 **Volumes** | Delete postgres, elasticsearch, tor, grafana data |
| 🌐 **Networks** | Remove `osint-net` bridge network |
| 📁 **Files** | Delete `~/osint-suite/docker/` directory |
| 🧹 **Optional** | `docker system prune` for full cleanup |

## ✅ Safety Features

- ✅ **Confirmation prompts** before destructive actions
- ✅ **Per-step progress** with clear feedback
- ✅ **Error handling** — continues even if one step fails
- ✅ **`--keep-config`** mode backs up `.env` to `~/.osint_env_backup`
- ✅ **Cleans `.bashrc`** of OSINT PATH additions
- ✅ **No accidental deletion** — nuclear option requires explicit `y`

## 💡 Recommended Workflow

```bash
# 1. Check what's installed
~/osint-uninstall.sh --status

# 2. Backup API keys (optional)
cp ~/osint-suite/config/.env ~/my_osint_env_backup

# 3. Selective uninstall (test)
~/osint-uninstall.sh
# Choose: 1 (Selective) → 7 (WebUI only)

# 4. Full uninstall
~/osint-uninstall.sh --full

# 5. Remove Docker too
~/osint-uninstall.sh --docker-only

# 6. Nuclear option (last resort)
~/osint-uninstall.sh
# Choose: 5
```

## ⚠ Important Notes

- **Docker is optional** in modes 1, 2, and `--full` — you can keep your 
containers running
- **Nuclear option** is irreversible — be sure before confirming
- **API keys** are deleted by default — use `--keep-config` to preserve them
- **Docker volumes** contain all your scan data — backup before uninstall

Want me to add a **dry-run mode** that shows what would be deleted without 
actually deleting, or a **reinstall script** that rebuilds from scratch? �

>>> ls
# 📂 OSINT Ultimate Suite — Master Listing

Here's the **complete file listing** of everything we've created in this session:

## 🕵 Core Scripts

| # | Filename | Description |
|---|----------|-------------|
| 1 | `install_osint_tools.sh` | **v1.0** — Original basic bulk installer |
| 2 | `osint-installer.sh` | **v2.0** — Menu-driven TUI (5 categories) |
| 3 | `osint-suite-installer.sh` | **v2.5** — + API wizard + Docker stack |
| 4 | `osint-suite-full.sh` | **v3.0** — Comprehensive 200+ tools |
| 5 | `osint-mega-suite.sh` | **Mega** — All 4 versions consolidated |
| 6 | `osint-v3.sh` | **v3** — Clean standalone v3 |
| 7 | `osint-ultimate.sh` | **Ultimate** — v3 + WebUI v2 |
| 8 | `osint-ultimate-final.sh` | **Final** — All upgrades baked in |
| 9 | **`osint-ultimate-final.sh`** ⭐ | **THE definitive single-file** |

## 🗑 Cleanup Tools

| # | Filename | Description |
|---|----------|-------------|
| 10 | **`osint-uninstall.sh`** ⭐ | **Docker-optional uninstaller** |

## 🩹 Patches & Add-ons

| # | Filename | Description |
|---|----------|-------------|
| 11 | `webui_patch.sh` | TUI → WebUI patch v1 |
| 12 | `webui_v2_patch.sh` | WebUI v2.0 patch (Auth/HTTPS/Themes/Docker) |

---

## 📊 Summary

- **9 installer scripts** (v1 → ultimate-final)
- **1 uninstaller** (Docker-optional)
- **2 patches** (WebUI v1 + v2)
- **Total: 12 files**

## ⭐ Recommended Files to Keep

```
~/osint-ultimate-final.sh    # The ONE installer you need
~/osint-uninstall.sh         # For cleanup
~/osint-suite/               # Generated install directory
```

## 📁 After Running — Directory Layout

```
~/osint-suite/
├── 📄 installed_tools.txt
├── 📁 python/              # Python tool clones
├── 📁 data/                # Wordlists, templates
├── 📁 go-bin/              # Go binaries
├── 📁 bin/                 # Downloaded binaries
├── 📁 config/
│   ├── .env                # API keys (chmod 600)
│   ├── .env.template
│   └── .webhooks
├── 📁 logs/                # install_YYYYMMDD.log
├── 📁 docker/              # Docker stack + Grafana/Prometheus
│   ├── docker-compose.yml
│   ├── Makefile
│   └── ...service files
└── 📁 webui/               # WebUI v2.0 (after --webui)
    ├── webui.py
    ├── .credentials        # Auto-generated admin creds
    ├── .ip_whitelist
    ├── templates/
    ├── static/
    ├── ssl/                # Self-signed certs
    ├── service-worker/
    └── db/history.db       # SQLite install history
```

## 🎯 Quick Reference Commands

```bash
# Install
~/osint-ultimate-final.sh                    # TUI menu
~/osint-ultimate-final.sh --webui            # Setup + launch WebUI

# Cleanup
~/osint-uninstall.sh                         # Interactive
~/osint-uninstall.sh --full                  # Everything (no Docker)
~/osint-uninstall.sh --all                   # Everything + Docker
~/osint-uninstall.sh --docker-only           # Just Docker stack
~/osint-uninstall.sh --status                # Show what's installed

# Helper
source ~/osint-suite/source_me.sh            # Add to PATH
