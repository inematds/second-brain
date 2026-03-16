#!/bin/bash
set -e

# ─────────────────────────────────────────────────────────────────────────────
#  SECOND BRAIN — One-command setup for Obsidian + Claude Code
# ─────────────────────────────────────────────────────────────────────────────

# SCRIPT_DIR must be defined first — used throughout
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Self-bootstrap: if repo files are missing, clone them ────────────────────
# This happens when the script is run via the one-liner curl command.
# We clone the full repo into a temp dir and re-exec from there.
if [ ! -f "$SCRIPT_DIR/CLAUDE.md" ]; then
  echo "Downloading Second Brain repo..."
  BOOTSTRAP_DIR="$(mktemp -d)"
  if ! git clone --depth=1 https://github.com/earlyaidopters/second-brain.git "$BOOTSTRAP_DIR" &>/dev/null; then
    echo "Error: Could not clone repo. Check your internet connection and try again."
    exit 1
  fi
  exec bash "$BOOTSTRAP_DIR/setup.sh"
fi

PURPLE='\033[0;35m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
RESET='\033[0m'

clear
echo ""
echo -e "${PURPLE}"
cat << 'ASCII'
  ███████╗███████╗ ██████╗ ██████╗ ███╗   ██╗██████╗
  ██╔════╝██╔════╝██╔════╝██╔═══██╗████╗  ██║██╔══██╗
  ███████╗█████╗  ██║     ██║   ██║██╔██╗ ██║██║  ██║
  ╚════██║██╔══╝  ██║     ██║   ██║██║╚██╗██║██║  ██║
  ███████║███████╗╚██████╗╚██████╔╝██║ ╚████║██████╔╝
  ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝

  ██████╗ ██████╗  █████╗ ██╗███╗   ██╗
  ██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║
  ██████╔╝██████╔╝███████║██║██╔██╗ ██║
  ██╔══██╗██╔══██╗██╔══██║██║██║╚██╗██║
  ██████╔╝██║  ██║██║  ██║██║██║ ╚████║
  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
ASCII
echo -e "${RESET}"
echo -e "${DIM}  Obsidian + Claude Code · Your AI-powered second brain${RESET}"
echo ""
echo -e "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "  ${WHITE}What this script installs:${RESET}"
echo ""
echo -e "  ${PURPLE}Obsidian${RESET}              Free note-taking app. Notes live as plain text files"
echo -e "                        on your computer — private, local, forever yours."
echo ""
echo -e "  ${PURPLE}Claude Code${RESET}           Anthropic's AI that runs in your terminal. Reads and"
echo -e "                        writes your vault directly — no copy-pasting."
echo ""
echo -e "  ${PURPLE}Python packages${RESET}       Background libraries used by Gemini 3 Flash to read"
echo -e "                        and synthesize your existing files (PDFs, docs, slides)."
echo ""
echo -e "  ${PURPLE}Vault skills${RESET}          Slash commands that teach Claude how to use your vault:"
echo -e "                        /vault-setup  /daily  /tldr  /file-intel"
echo ""
echo -e "  ${PURPLE}Obsidian Skills${RESET}       Official skills by Kepano (Obsidian CEO) — lets Claude"
echo -e "  ${DIM}(optional)${RESET}            navigate your vault using the Obsidian CLI."
echo ""
echo -e "  ${DIM}  Nothing is uploaded. Your vault stays on your machine.${RESET}"
echo ""
echo -e "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ─── STEP 1: Detect OS ──────────────────────────────────────────────────────
if [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macos"
elif [[ "$OSTYPE" == "linux"* ]]; then
  PLATFORM="linux"
else
  echo -e "${ORANGE}⚠️  This setup script supports macOS and Linux.${RESET}"
  echo "   Windows: run setup.ps1 instead."
  exit 1
fi

echo -e "${WHITE}Step 1/7 — Checking dependencies${RESET}"
echo -e "  ${DIM}Detected platform: $PLATFORM${RESET}"

# ─── STEP 2: Package manager ────────────────────────────────────────────────
if [[ "$PLATFORM" == "macos" ]]; then
  if ! command -v brew &>/dev/null; then
    echo "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo -e "  ${GREEN}✓${RESET} Homebrew already installed"
  fi
elif [[ "$PLATFORM" == "linux" ]]; then
  # Detect Linux package manager
  if command -v apt &>/dev/null; then
    PKG_MGR="apt"
    echo -e "  ${GREEN}✓${RESET} Package manager: apt (Debian/Ubuntu)"
  elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
    echo -e "  ${GREEN}✓${RESET} Package manager: dnf (Fedora/RHEL)"
  elif command -v pacman &>/dev/null; then
    PKG_MGR="pacman"
    echo -e "  ${GREEN}✓${RESET} Package manager: pacman (Arch)"
  else
    PKG_MGR="unknown"
    echo -e "  ${ORANGE}⚠${RESET}  Could not detect package manager — you may need to install dependencies manually"
  fi
fi

# ─── STEP 3: Obsidian ────────────────────────────────────────────────────────
echo ""
echo -e "${WHITE}Step 2/7 — Installing Obsidian${RESET}"

install_obsidian_linux() {
  # Try Snap first, then Flatpak, then suggest AppImage
  if command -v snap &>/dev/null; then
    echo "  Installing Obsidian via Snap..."
    sudo snap install obsidian --classic \
      && echo -e "  ${GREEN}✓${RESET} Obsidian installed (Snap)" \
      || echo -e "  ${ORANGE}⚠${RESET}  Snap install failed — try: flatpak install flathub md.obsidian.Obsidian"
  elif command -v flatpak &>/dev/null; then
    echo "  Installing Obsidian via Flatpak..."
    flatpak install -y flathub md.obsidian.Obsidian \
      && echo -e "  ${GREEN}✓${RESET} Obsidian installed (Flatpak)" \
      || echo -e "  ${ORANGE}⚠${RESET}  Flatpak install failed — download AppImage from https://obsidian.md/download"
  else
    echo -e "  ${ORANGE}⚠${RESET}  Neither Snap nor Flatpak found."
    echo -e "  ${DIM}  Install Obsidian manually:${RESET}"
    echo -e "  ${DIM}    - Snap: sudo snap install obsidian --classic${RESET}"
    echo -e "  ${DIM}    - Flatpak: flatpak install flathub md.obsidian.Obsidian${RESET}"
    echo -e "  ${DIM}    - AppImage: https://obsidian.md/download${RESET}"
  fi
}

if [[ "$PLATFORM" == "macos" ]]; then
  if ! brew list --cask obsidian &>/dev/null 2>&1; then
    echo "  Installing Obsidian..."
    brew install --cask obsidian
    echo -e "  ${GREEN}✓${RESET} Obsidian installed"
  else
    echo -e "  ${GREEN}✓${RESET} Obsidian already installed"
  fi
elif [[ "$PLATFORM" == "linux" ]]; then
  # Check if Obsidian is already available
  if command -v obsidian &>/dev/null || snap list obsidian &>/dev/null 2>&1 || flatpak list 2>/dev/null | grep -q obsidian; then
    echo -e "  ${GREEN}✓${RESET} Obsidian already installed"
  else
    install_obsidian_linux
  fi
fi

# ─── STEP 4: Claude Code ─────────────────────────────────────────────────────
echo ""
echo -e "${WHITE}Step 3/7 — Installing Claude Code CLI${RESET}"
if ! command -v claude &>/dev/null; then
  echo "  Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | sh
  echo -e "  ${GREEN}✓${RESET} Claude Code installed"
  echo -e "  ${DIM}  Note: restart terminal if 'claude' isn't found after setup${RESET}"
else
  echo -e "  ${GREEN}✓${RESET} Claude Code already installed"
fi

# ─── STEP 5: Python deps (venv to avoid PEP 668) ─────────────────────────────
echo ""
echo -e "${WHITE}Step 4/7 — Installing Python dependencies${RESET}"
if command -v python3 &>/dev/null; then
  VENV_DIR="$HOME/.second-brain-venv"
  python3 -m venv "$VENV_DIR" 2>/dev/null || true
  "$VENV_DIR/bin/pip" install -q -r "$SCRIPT_DIR/requirements.txt" \
    && echo -e "  ${GREEN}✓${RESET} Python packages installed" \
    || echo -e "  ${ORANGE}⚠${RESET}  pip install failed — try: pip3 install -r requirements.txt --break-system-packages"
else
  if [[ "$PLATFORM" == "macos" ]]; then
    echo -e "  ${ORANGE}⚠${RESET}  Python 3 not found. Install: brew install python3"
  else
    echo -e "  ${ORANGE}⚠${RESET}  Python 3 not found. Install: sudo apt install python3 python3-pip python3-venv"
  fi
fi

# ─── STEP 6: Vault setup ─────────────────────────────────────────────────────
echo ""
echo -e "${WHITE}Step 5/7 — Setting up your vault${RESET}"
echo ""
echo -e "  Where should your second brain live?"
echo -e "  ${DIM}Press Enter for default: ~/vault${RESET}"
read -p "  Vault path: " VAULT_PATH
VAULT_PATH="${VAULT_PATH:-$HOME/vault}"
VAULT_PATH="${VAULT_PATH/#\~/$HOME}"

# Guard: don't let vault = the repo folder (causes identical file cp errors)
if [ "$VAULT_PATH" = "$SCRIPT_DIR" ]; then
  echo -e "  ${ORANGE}⚠${RESET}  Vault can't be the same folder as the repo. Using ~/vault instead."
  VAULT_PATH="$HOME/vault"
fi

mkdir -p "$VAULT_PATH"/{inbox,daily,projects,research,archive,scripts,.claude/skills/vault-setup,.claude/skills/daily,.claude/skills/tldr,.claude/skills/file-intel}

cp "$SCRIPT_DIR/CLAUDE.md"  "$VAULT_PATH/CLAUDE.md"
cp "$SCRIPT_DIR/memory.md"  "$VAULT_PATH/memory.md"
cp "$SCRIPT_DIR/skills/vault-setup/SKILL.md" "$VAULT_PATH/.claude/skills/vault-setup/SKILL.md"
cp "$SCRIPT_DIR/skills/daily/SKILL.md"       "$VAULT_PATH/.claude/skills/daily/SKILL.md"
cp "$SCRIPT_DIR/skills/tldr/SKILL.md"        "$VAULT_PATH/.claude/skills/tldr/SKILL.md"
cp "$SCRIPT_DIR/skills/file-intel/SKILL.md"  "$VAULT_PATH/.claude/skills/file-intel/SKILL.md"
cp "$SCRIPT_DIR/scripts/process_docs_to_obsidian.py" "$VAULT_PATH/scripts/process_docs_to_obsidian.py"
cp "$SCRIPT_DIR/scripts/process_files_with_gemini.py" "$VAULT_PATH/scripts/process_files_with_gemini.py"

# Also install skills globally so they work in ANY folder, not just the vault
mkdir -p "$HOME/.claude/skills/vault-setup" "$HOME/.claude/skills/daily" \
         "$HOME/.claude/skills/tldr" "$HOME/.claude/skills/file-intel"
cp "$SCRIPT_DIR/skills/vault-setup/SKILL.md" "$HOME/.claude/skills/vault-setup/SKILL.md"
cp "$SCRIPT_DIR/skills/daily/SKILL.md"       "$HOME/.claude/skills/daily/SKILL.md"
cp "$SCRIPT_DIR/skills/tldr/SKILL.md"        "$HOME/.claude/skills/tldr/SKILL.md"
cp "$SCRIPT_DIR/skills/file-intel/SKILL.md"  "$HOME/.claude/skills/file-intel/SKILL.md"

echo -e "  ${GREEN}✓${RESET} Vault created at $VAULT_PATH"
echo -e "  ${GREEN}✓${RESET} Skills installed globally — work in any folder"

# ─── STEP 7: API key ─────────────────────────────────────────────────────────
echo ""
echo -e "  ${CYAN}Get your free Google API key at: https://aistudio.google.com/apikey${RESET}"
echo -e "  ${DIM}(Used by Gemini 3 Flash to process your existing files — free tier works)${RESET}"
echo ""
read -p "  Paste your Google API key (or press Enter to skip): " GOOGLE_KEY

if [ -n "$GOOGLE_KEY" ]; then
  echo "GOOGLE_API_KEY=$GOOGLE_KEY" > "$VAULT_PATH/.env"
  echo -e "  ${GREEN}✓${RESET} API key saved to $VAULT_PATH/.env"
else
  cp "$SCRIPT_DIR/.env.example" "$VAULT_PATH/.env"
  echo -e "  ${ORANGE}⚠${RESET}  Skipped — add your key to $VAULT_PATH/.env before processing files"
fi

# ─── STEP 8: Import existing files ───────────────────────────────────────────
echo ""
echo -e "${WHITE}Step 6/7 — Import existing files (optional)${RESET}"
echo ""
echo -e "  Do you have existing files to import? (PDFs, Word docs, slides)"
echo -e "  ${DIM}Gemini 3 Flash will synthesize them into clean Markdown notes${RESET}"
echo ""
read -p "  Folder path to import (or press Enter to skip): " IMPORT_FOLDER

if [ -n "$IMPORT_FOLDER" ] && [ -d "$IMPORT_FOLDER" ]; then
  echo ""
  echo "  Processing files with Gemini 3 Flash..."
  "$HOME/.second-brain-venv/bin/python3" "$VAULT_PATH/scripts/process_docs_to_obsidian.py" \
    "$IMPORT_FOLDER" "$VAULT_PATH/inbox"
  echo ""
  echo -e "  ${GREEN}✓${RESET} Files processed → saved to $VAULT_PATH/inbox"
  echo -e "  ${DIM}Open Claude Code and say: \"Sort everything in inbox/ into the right folders\"${RESET}"
elif [ -n "$IMPORT_FOLDER" ]; then
  echo -e "  ${ORANGE}⚠${RESET}  Folder not found: $IMPORT_FOLDER"
fi

# ─── STEP 7: Kepano Obsidian Skills (optional) ──────────────────────────────
echo ""
echo -e "${WHITE}Step 7/7 — Obsidian Skills by Kepano (optional)${RESET}"
echo ""
echo -e "  Kepano (Steph Ango) is the CEO of Obsidian. He published a set of"
echo -e "  official agent skills that teach Claude Code to natively read, write,"
echo -e "  and navigate your vault using the Obsidian CLI."
echo ""
echo -e "  Adds these slash commands to Claude Code:"
echo -e "  ${DIM}  obsidian-cli · obsidian-markdown · obsidian-bases · json-canvas${RESET}"
echo ""
read -p "  Install Kepano's Obsidian skills? [Y/n]: " KEPANO_ANSWER
KEPANO_ANSWER="${KEPANO_ANSWER:-Y}"

if [[ "$KEPANO_ANSWER" =~ ^[Yy] ]]; then
  echo "  Cloning obsidian-skills..."
  TEMP_DIR=$(mktemp -d)
  if git clone --depth=1 https://github.com/kepano/obsidian-skills.git "$TEMP_DIR/obsidian-skills" &>/dev/null; then
    for skill_dir in "$TEMP_DIR/obsidian-skills/skills"/*/; do
      skill_name=$(basename "$skill_dir")
      # Install to vault AND globally
      mkdir -p "$VAULT_PATH/.claude/skills/$skill_name" "$HOME/.claude/skills/$skill_name"
      cp "$skill_dir/SKILL.md" "$VAULT_PATH/.claude/skills/$skill_name/SKILL.md" 2>/dev/null || true
      cp "$skill_dir/SKILL.md" "$HOME/.claude/skills/$skill_name/SKILL.md" 2>/dev/null || true
    done
    rm -rf "$TEMP_DIR"
    echo -e "  ${GREEN}✓${RESET} Kepano's Obsidian skills installed (vault + global)"
  else
    rm -rf "$TEMP_DIR"
    echo -e "  ${ORANGE}⚠${RESET}  Couldn't reach GitHub. Install manually later:"
    echo -e "  ${DIM}  https://github.com/kepano/obsidian-skills${RESET}"
  fi
else
  echo -e "  ${DIM}  Skipped — install anytime: https://github.com/kepano/obsidian-skills${RESET}"
fi

# ─── VERIFICATION ────────────────────────────────────────────────────────────
echo ""
echo -e "  ${WHITE}Checking installation...${RESET}"
echo ""

if [[ "$PLATFORM" == "macos" ]]; then
  if brew list --cask obsidian &>/dev/null 2>&1; then
    echo -e "  ${GREEN}✓${RESET} Obsidian"
  else
    echo -e "  ${ORANGE}✗${RESET} Obsidian — run: brew install --cask obsidian"
  fi
elif [[ "$PLATFORM" == "linux" ]]; then
  if command -v obsidian &>/dev/null || snap list obsidian &>/dev/null 2>&1 || flatpak list 2>/dev/null | grep -q obsidian; then
    echo -e "  ${GREEN}✓${RESET} Obsidian"
  else
    echo -e "  ${ORANGE}✗${RESET} Obsidian — install via snap, flatpak, or AppImage (https://obsidian.md/download)"
  fi
fi

if command -v claude &>/dev/null; then
  echo -e "  ${GREEN}✓${RESET} Claude Code  $(claude --version 2>/dev/null | head -1)"
else
  echo -e "  ${ORANGE}✗${RESET} Claude Code not in PATH — restart terminal then run: claude"
fi

if command -v python3 &>/dev/null; then
  echo -e "  ${GREEN}✓${RESET} $(python3 --version 2>&1)"
else
  if [[ "$PLATFORM" == "macos" ]]; then
    echo -e "  ${ORANGE}✗${RESET} Python 3 not found — run: brew install python3"
  else
    echo -e "  ${ORANGE}✗${RESET} Python 3 not found — run: sudo apt install python3 python3-pip python3-venv"
  fi
fi

if [ -f "$VAULT_PATH/CLAUDE.md" ]; then
  echo -e "  ${GREEN}✓${RESET} Vault  $VAULT_PATH"
else
  echo -e "  ${ORANGE}✗${RESET} Vault files missing at $VAULT_PATH"
fi

# ─── DONE ────────────────────────────────────────────────────────────────────
echo ""
echo -e "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "  ${GREEN}✅ Your second brain is ready.${RESET}"
echo ""
echo -e "  ${WHITE}Vault:${RESET} $VAULT_PATH"
echo ""
echo -e "  ${WHITE}Next steps:${RESET}"
echo -e "  ${CYAN}1.${RESET} Open Obsidian → open vault → ${DIM}$VAULT_PATH${RESET}"
echo -e "  ${CYAN}2.${RESET} Settings → General → Enable Command Line Interface"
echo -e "  ${CYAN}3.${RESET} In a new terminal:"
echo -e "     ${DIM}cd $VAULT_PATH && claude${RESET}"
echo -e "  ${CYAN}4.${RESET} Type ${DIM}/vault-setup${RESET} — Claude Code will personalize your vault"
echo ""

# Open Obsidian
if [[ "$PLATFORM" == "macos" ]]; then
  open -a Obsidian "$VAULT_PATH" 2>/dev/null || open -a Obsidian 2>/dev/null || true
elif [[ "$PLATFORM" == "linux" ]]; then
  if command -v obsidian &>/dev/null; then
    obsidian "$VAULT_PATH" &>/dev/null &
  elif command -v xdg-open &>/dev/null; then
    xdg-open "$VAULT_PATH" &>/dev/null &
  fi
fi
