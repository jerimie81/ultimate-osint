#!/bin/bash

###############################################################################
# 🗑  OSINT UNINSTALLER — Docker Optional
###############################################################################

set -u
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; 
NC='\033[0m'

INSTALL_DIR="$HOME/osint-suite"

uninstall_python_tools() {
    [ -f "$INSTALL_DIR/installed_tools.txt" ] || return
    while IFS= read -r tool; do
        [ -z "$tool" ] && continue
        case "$tool" in
            sherlock) pkg="sherlock-project" ;;
            *) pkg="$tool" ;;
        esac
        pip3 uninstall -y "$pkg" 2>/dev/null
    done < "$INSTALL_DIR/installed_tools.txt"
}

remove_docker_stack() {
    if ! command -v docker &> /dev/null; then return; fi
    cd "$INSTALL_DIR/docker" 2>/dev/null && docker compose down 2>/dev/null
    docker ps -a --filter "name=osint-" -q 2>/dev/null | xargs -r docker rm -f 
2>/dev/null
    docker images --filter "reference=osint-*" -q 2>/dev/null | xargs -r docker 
rmi -f 2>/dev/null
    docker volume ls --filter "name=osint" -q 2>/dev/null | xargs -r docker volume 
rm 2>/dev/null
    docker network rm osint-net 2>/dev/null
    rm -rf "$INSTALL_DIR/docker"
}

full_no_docker() {
    [ ! -d "$INSTALL_DIR" ] && { echo "Not installed"; exit 0; }
    uninstall_python_tools
    rm -rf "$INSTALL_DIR/python" "$INSTALL_DIR/data" "$INSTALL_DIR/go-bin" \
           "$INSTALL_DIR/bin" "$INSTALL_DIR/config" "$INSTALL_DIR/logs" \
           "$INSTALL_DIR/webui"
    echo "✅ Uninstalled (Docker preserved)"
}

full_with_docker() {
    full_no_docker
    remove_docker_stack
    echo "✅ Fully uninstalled"
}

nuclear() {
    rm -rf "$INSTALL_DIR"
    [ -f "$HOME/.bashrc" ] && sed -i '/osint-suite/d' "$HOME/.bashrc"
    echo "☢ Nuclear uninstall complete"
}

case "${1:-}" in
    --full) full_no_docker ;;
    --all) full_with_docker ;;
    --docker-only) remove_docker_stack ;;
    --nuclear) nuclear ;;
    *) 
        echo "Usage: $0 [--full|--all|--docker-only|--nuclear]"
        exit 1
        ;;
esac
```
