# 🕵 OSINT Ultimate Suite

**A Comprehensive Open-Source Intelligence Toolkit for Linux**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![GitHub 
release](https://img.shields.io/github/v/release/yourusername/osint-ultimate-suite)release](https://img.shields.io/github/v/release/yourusername/osint-ultimte-suite)](https://github.com/yourusername/osint-ultimate-suite/releases)
[![GitHub 
stars](https://img.shields.io/github/stars/yourusername/osint-ultimate-suite)](httpstars](https://img.shields.io/github/stars/yourusername/osint-ultimate-sute)](https://github.com/yourusername/osint-ultimate-suite/stargazers)
[![GitHub 
forks](https://img.shields.io/github/forks/yourusername/osint-ultimate-suite)](httpforks](https://img.shields.io/github/forks/yourusername/osint-ultimate-sute)](https://github.com/yourusername/osint-ultimate-suite/network)
[![GitHub 
issues](https://img.shields.io/github/issues/yourusername/osint-ultimate-suite)](htissues](https://img.shields.io/github/issues/yourusername/osint-ultimate-uite)](https://github.com/yourusername/osint-ultimate-suite/issues)
[![CI](https://github.com/yourusername/osint-ultimate-suite/workflows/CI/badge.svg)[![CI](https://github.com/yourusername/osint-ultimate-suite/workflows/CI/badge.svg)](.github/workflows/ci.yml)
[![Code style: 
bash](https://img.shields.io/badge/code%20style-bash-blue.svg)](https://www.gnu.orgbash](https://img.shields.io/badge/code%20style-bash-blue.svg)](http://www.gnu.org/software/bash/)
[![Made with 
Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.orBash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https//www.gnu.org/software/bash/)
[![PRs 
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.mdWelcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUING.md)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/yourusername/osint-ultimate-suite/graphs/commit-activity)

**200+ Tools • 14 Categories • WebUI v2.0 • Docker Stack • PWA**

[Features](#-features) • [Quick Start](#-quick-start) • [Documentation](docs/) • 
[Contributing](CONTRIBUTING.md) • [License](LICENSE)

</div>

---

## ⚠ Legal & Ethical Use Notice

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║         🔒 AUTHORIZATION REQUIRED FOR ALL TARGETS                        ║
║         ⚖  Only test systems YOU OWN or have EXPLICIT WRITTEN PERMISSION║
║         📜 Unauthorized use violates CFAA, GDPR, and local laws          ║
║         🎓 For authorized security testing, journalism, and education    ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
```

**By using this software, you agree to:**
- ✅ Obtain explicit written authorization before testing any targets
- ✅ Comply with all applicable laws in your jurisdiction
- ✅ Use the tools ethically and responsibly
- ✅ Report vulnerabilities through proper channels
- ❌ **NEVER** use for unauthorized access, stalking, harassment, or illegal 
surveillance

The developers are **not responsible for misuse** of these tools.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Usage](#-usage)
- [Categories](#-categories)
- [WebUI v2.0](#-webui-v20)
- [Docker Stack](#-docker-stack)
- [Screenshots](#-screenshots)
- [Documentation](#-documentation)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [Security](#-security)
- [License](#-license)
- [Acknowledgments](#-acknowledgments)

---

## 🎯 Overview

**OSINT Ultimate Suite** is a comprehensive Linux CLI toolkit that bundles **200+ 
carefully curated open-source intelligence tools** across **14 specialized 
categories**. It features an integrated **WebUI v2.0** with authentication, a 
**Docker Compose stack** with Grafana/Prometheus monitoring, and **all modern 
upgrades** including PWA support, SQLite history tracking, and webhook 
notifications.

Built for:
- 🔒 **Security researchers** conducting authorized penetration tests
- 🕵 **OSINT investigators** doing legitimate research
- 📰 **Journalists** investigating stories (with legal authorization)
- 🎓 **Students** learning cybersecurity and OSINT methodologies
- 🏢 **Red teams** performing reconnaissance

## ✨ Features

### 🛠 Core Toolkit

| Feature | Description |
|---------|-------------|
| 📦 **200+ Tools** | Carefully curated from GitHub across 14 categories |
| 🎯 **14 Categories** | Organized by use case (username, email, domain, etc.) |
| 🔄 **Auto-Update** | One command updates all installed tools |
| 🎨 **Multi-Distro** | Supports apt (Debian/Kali/Ubuntu), dnf (Fedora/RHEL), 
pacman (Arch) |
| 📝 **Smart Installer** | Auto-detects pip/go/system packages and installs 
appropriately |
| 📊 **Bulk Mode** | Install everything with one flag (`--install-all`) |
| 📋 **Cheat Sheet** | Auto-generated workflow reference |

### 🌐 WebUI v2.0

| Feature | Description |
|---------|-------------|
| � **Authentication** | Flask-Login with SHA-256 password hashing |
| 🔒 **HTTPS** | Self-signed TLS auto-generated (replaceable with Let's Encrypt) |
| 🌓 **Dark/Light Themes** | Persisted in localStorage |
| 🐳 **Live Docker Status** | Real-time container monitoring with 8 actions |
| 📱 **PWA** | Progressive Web App - installable on mobile/desktop |
| 📜 **SQLite History** | All user actions logged with timestamp/user/status |
| 🛡 **IP Whitelist** | Restrict access by IP/CIDR |
| 🔔 **Webhooks** | Telegram, Discord, Slack notifications |
| � **Session Security** | 30-min timeout, HTTPOnly + Secure cookies |
| 🌐 **Service Worker** | Offline-capable PWA support |

### 🐳 Docker Stack

| Service | Port | Purpose |
|---------|------|---------|
| 🕷 SpiderFoot | 5001 | 200+ source OSINT collection |
| 🛠 Recon-ng | CLI | Modular recon framework |
| � Grafana | 3000 | Metrics visualization (admin/admin) |
| � Prometheus | 9090 | Metrics scraping |
| 🐘 PostgreSQL | 5432 | SpiderFoot database |
| 🔍 Elasticsearch | 9200 | Log aggregation |
| 📡 Tor SOCKS | 9050 | Anonymous recon |
| 🌐 Nginx Dashboard | 8080 | Landing page with service links |

## 🚀 Quick Start

### Prerequisites

- **OS**: Linux (Kali/Ubuntu/Debian/Fedora/Arch)
- **Python**: 3.8 or higher
- **Go**: 1.20 or higher (for Go-based tools)
- **Disk Space**: ~5GB free
- **RAM**: 4GB minimum (8GB recommended)
- **Docker**: Optional but recommended (for Docker stack)

### 📥 Installation

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/osint-ultimate-suite.git
cd osint-ultimate-suite

# 2. Make scripts executable
chmod +x scripts/*.sh

# 3. Run the installer
./scripts/install.sh
```

### 🖥 Launch WebUI

```bash
# Set up and launch WebUI
./scripts/install.sh --webui

# � IMPORTANT: Save the auto-generated credentials!
# Browser auto-opens to https://localhost:5000
# (You'll need to accept the self-signed cert warning)
```

### 🐳 Start Docker Stack

```bash
cd ~/osint-suite/docker
make up
# Services available at:
#   Dashboard:     http://localhost:8080
#   SpiderFoot:    http://localhost:5001
#   Grafana:       http://localhost:3000
#   Prometheus:    http://localhost:9090
```

### 🗑 Uninstall

```bash
./scripts/uninstall.sh --full      # Everything (Docker preserved)
./scripts/uninstall.sh --all       # Everything + Docker stack
./scripts/uninstall.sh --docker-only  # Just Docker
./scripts/uninstall.sh --help      # See all options
```

## 📥 Installation

### From GitHub

```bash
git clone https://github.com/yourusername/osint-ultimate-suite.git
cd osint-ultimate-suite
./scripts/install.sh
```

### From Release Archive

```bash
# Download latest release
wget 
https://github.com/yourusername/osint-ultimate-suite/releases/download/v3.0.0/osinthttps://github.com/yourusername/osint-ultimate-suite/releases/download/v3.0.0/sint-ultimate-suite.tar.gz
tar -xzf osint-ultimate-suite.tar.gz
cd osint-ultimate-suite
./scripts/install.sh
```

### System Dependencies

The installer will check and install:
- `python3-pip`, `git`, `curl`, `wget`
- `golang-go`, `nmap`, `whois`, `dnsutils`
- `hydra`, `exiftool`, `geoip-bin`
- `tor`, `netdiscover`, `sslscan`
- `build-essential`, `libssl-dev`

## 🎮 Usage

### TUI Menu (Default)

```bash
./scripts/install.sh
```

Interactive menu with 14 categories and 200+ tools.

### Command Line

```bash
./scripts/install.sh --help        # Show all options
./scripts/install.sh --webui       # Setup & launch WebUI
./scripts/install.sh --install-all # Bulk install everything
./scripts/install.sh --update      # Update all installed tools
```

### After Installation

```bash
# Add tools to PATH
source ~/osint-suite/source_me.sh

# Quick tools
sherlock username              # Username search
holehe email@example.com       # Email registration check
subfinder -d domain.com        # Subdomain enumeration
amass enum -d domain.com       # Attack surface mapping
exiftool image.jpg             # Extract EXIF metadata
nuclei -l urls.txt             # Vulnerability scanning

# Docker stack
cd ~/osint-suite/docker
make up        # Start
make down      # Stop
make logs      # View logs
```

## 📂 Categories

| # | Category | Tools | Highlights |
|---|----------|-------|-----------|
| 1 | 👤 **Username/Identity** | 12 | sherlock, maigret, blackbird, whapa |
| 2 | 📧 **Email** | 12 | holehe, ghunt, mosint, CrossLinked |
| 3 | 🌐 **Domain/DNS** | 18 | subfinder, amass, shuffledns, katana |
| 4 | 📱 **Phone/Metadata** | 9 | phoneinfoga, metagoofil, exiftool |
| 5 | � **Social Media** | 15 | twint, Osintgram, yt-dlp, snscrape |
| 6 | 🛠 **Frameworks** | 12 | recon-ng, SpiderFoot, OSRFramework |
| 7 | 🗺 **Geolocation** | 11 | seeker, GeoIP2, WiGLE, mmdbinspect |
| 8 | 🔗 **Web/URL** | 20 | katana, httpx, gowitness, waybackurls |
| 9 | 🔓 **Breach/Credentials** | 10 | h8mail, LeakLooker, scylla |
| 10 | 📡 **Network/WAF/TLS** | 20 | rustscan, naabu, shodan-cli, censys-cli |
| 11 | 🕸 **Dark Web/Tor** | 9 | onionsearch, TorBot, onionshare |
| 12 | 📚 **Wordlists** | 15 | SecLists, nuclei-templates, CUPP |
| 13 | ₿ **Crypto/Blockchain** | 10 | bitcoinlib, web3, btcrecover, chainabuse |
| 14 | ⚡ **Misc/Niche** | 26 | bbot, gitleaks, XSStrike, sqlmap, s3scanner |
| | **TOTAL** | **200+** | |

## 🌐 WebUI v2.0

### Features

| Feature | Description |
|---------|-------------|
| 🔐 **Login Screen** | Username/password with Flask-Login |
| 🌓 **Theme Toggle** | Dark/Light, persisted in localStorage |
| 📱 **PWA Install** | Click "Add to Home Screen" on mobile |
| 🐳 **Docker Panel** | Live status + 8 actions 
(up/down/restart/pull/rebuild/clean/logs/status) |
| 🔑 **API Keys** | Real-time status of all configured keys |
| 📜 **History** | SQLite-backed log of all actions |
| 📺 **Live Logs** | WebSocket-piped installation output |
| 🔔 **Webhooks** | Configured for Telegram/Discord/Slack |

### First Login

When you first run `--webui`, the system generates random credentials:

```
╔════════════════════════════════════════════════════╗
║  🔐 DEFAULT CREDENTIALS GENERATED                  ║
�  Username: admin                                   ║
║  Password: AbCdEf123456                            ║
║  ⚠  SAVE THESE NOW!                               ║
╚════════════════════════════════════════════════════╝
```

Credentials are stored at `~/osint-suite/webui/.credentials` (chmod 600). **Change 
immediately after first login** via the password change page.

### Screenshots

*(WebUI screenshots coming soon)*

## 🐳 Docker Stack

### Quick Start

```bash
cd ~/osint-suite/docker
make up
```

### Services

After `make up`, access these services:

| Service | URL | Credentials |
|---------|-----|-------------|
| 🕷 SpiderFoot | http://localhost:5001 | (set on first visit) |
| 📊 Grafana | http://localhost:3000 | admin / admin |
| 📈 Prometheus | http://localhost:9090 | (no auth) |
| 🔍 Elasticsearch | http://localhost:9200 | (no auth) |
| 📡 Tor SOCKS | localhost:9050 | (SOCKS5 proxy) |
| 🌐 Dashboard | http://localhost:8080 | (landing page) |

### Useful Commands

```bash
make up              # Start all services
make down            # Stop all services
make logs            # Tail logs (all containers)
make status          # Show container status
make exec-toolkit    # Shell into toolkit container
make exec-recon      # Shell into recon-ng
make exec-spiderfoot # Shell into SpiderFoot
make rebuild         # Rebuild all images
make clean           # Remove containers + volumes (DANGER: deletes data)
```

## 📸 Screenshots

*(Coming soon — placeholder for WebUI, TUI menu, Grafana dashboards)*

## 📚 Documentation

- 📖 [Installation Guide](docs/INSTALL.md) — Detailed setup instructions
- 🎯 [Workflow Cheat Sheet](docs/CHEATSHEET.md) — Common reconnaissance workflows
- 🌐 [WebUI Guide](docs/WEBUI.md) — Web interface documentation
- 🐳 [Docker Setup](docs/DOCKER.md) — Docker stack deployment
- � [Contributing](CONTRIBUTING.md) — How to contribute

## 🗺 Roadmap

### ✅ Completed (v3.0)

- [x] 200+ tools across 14 categories
- [x] WebUI v2.0 with auth/HTTPS/themes
- [x] Docker stack with Grafana/Prometheus
- [x] PWA support
- [x] SQLite install history
- [x] Webhook notifications
- [x] IP whitelist
- [x] Cron scheduler

### � In Progress

- [ ] JupyterLab integration
- [ ] Automated PDF reports
- [ ] Multi-user role system
- [ ] Helm chart for Kubernetes

### 💡 Future Ideas

- [ ] Mobile push notifications
- [ ] Real-time collaboration (WebSocket rooms)
- [ ] PostgreSQL backend (replace SQLite for scale)
- [ ] GraphQL API
- [ ] VS Code extension
- [ ] Plugin marketplace

## 🤝 Contributing

We welcome contributions! 🎉

**Ways to contribute:**
- 🐛 Report bugs
- 💡 Suggest new tools or categories
- 📝 Improve documentation
- 🔧 Submit pull requests
- ⭐ Star the repo
- 🐦 Share on social media

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### Development Setup

```bash
git clone https://github.com/yourusername/osint-ultimate-suite.git
cd osint-ultimate-suite
git checkout -b feature/amazing-tool

# Make changes, then test
shellcheck scripts/*.sh
./scripts/install.sh --help

# Commit and push
git commit -m "feat: Add amazing-tool to category"
git push origin feature/amazing-tool
# Open a Pull Request
```

## 🛡 Security

### Reporting Vulnerabilities

**DO NOT** open a public GitHub issue for security vulnerabilities.

Report to: **security@yourdomain.com**

Include:
- Description of vulnerability
- Steps to reproduce
- Affected versions
- Potential impact
- Suggested fix (if any)

Response time: Within 48 hours.

See [SECURITY.md](SECURITY.md) for full policy.

### Security Best Practices
When deploying this suite:

- ✅ Generate strong unique password on first WebUI run
- ✅ Enable IP whitelist for remote access
- ✅ Use HTTPS only (never plain HTTP)
- ✅ Store API keys with `chmod 600`
- ✅ Enable webhook alerts for monitoring
- ✅ Review SQLite history regularly
- ✅ Keep tools updated (`./install.sh --update`)
- ✅ Run in isolated VM/container for production
- ❌ Never expose WebUI to public internet without auth + HTTPS + IP whitelist

## 📜 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) 
file for details.

```
MIT License - Copyright (c) 2024

⚠ ETHICAL USE CLAUSE:
This software is intended for authorized security testing, academic research,
and educational purposes only. Users are solely responsible for ensuring they
have explicit authorization before testing any systems or accounts.
```

## ⚠ Disclaimer

This software is provided "as is" for **educational and authorized testing 
purposes only**. The developers:

- ❌ Do NOT condone illegal use
- ❌ Are NOT responsible for misuse
- ❌ Do NOT provide support for unauthorized activities

**Users must:**
- ✅ Comply with all applicable laws (CFAA, GDPR, local laws)
- ✅ Obtain proper authorization before any testing
- ✅ Use ethically and responsibly

## 🙏 Acknowledgments

This project is built on the shoulders of giants. Special thanks to:

- All the open-source tool authors listed in [CHEATSHEET.md](docs/CHEATSHEET.md)
- [ProjectDiscovery](https://github.com/projectdiscovery) for the amazing recon 
tools
- [Tomnomnom](https://github.com/tomnomnom) for URL/grep utilities
- [OWASP](https://owasp.org/) for security resources
- [Kali Linux](https://www.kali.org/) team for the excellent penetration testing 
distro
- The entire OSINT community for knowledge sharing

## 📊 Stats

- ⭐ **200+ Tools** curated
- 📂 **14 Categories** organized
- 🐳 **8 Docker services** orchestrated
- 🔑 **30+ API providers** supported
- 🔔 **3 Webhook platforms** integrated
- 🌐 **5 WebUI panels** (Docker/Keys/History/Logs/Categories)

## 🌟 Star History

If this project helps you, please ⭐ star it!

## 💖 Support

If you'd like to support the project:
- ⭐ Star it on GitHub
- 🐛 Report bugs and contribute fixes
- 📢 Share with others
- 💰 Sponsor development (coming soon)

---

<div align="center">

**🕵 Made with ❤ for the OSINT community**

[⬆ Back to Top](#-osint-ultimate-suite)

</div>
```
