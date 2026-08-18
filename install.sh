#!/bin/bash
#  ___           _        _ _
# |_ _|_ __  ___| |_ __ _| | |
#  | || '_ \/ __| __/ _` | | |
#  | || | | \__ \ || (_| | | |
# |___|_| |_|___/\__\__,_|_|_|
#
# One-command bootstrap for a new macOS machine.
# Idempotent: safe to re-run at any time.
#
#   git clone --recurse-submodules https://github.com/larry-lime/dotfiles ~/.dotfiles
#   ~/.dotfiles/install.sh
#
# Flags:
#   --no-casks    skip GUI apps (Ghostty) and fonts
#   --no-remap    skip the option->ctrl key remap LaunchAgent
#   --no-henry    skip the ~/HenryLabs/henry worktree setup

set -uo pipefail

DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
TPM_DIR="$HOME/.config/tmux/.tmux/plugins/tpm"

INSTALL_CASKS=true
INSTALL_REMAP=true
INSTALL_HENRY=true
for arg in "$@"; do
  case "$arg" in
    --no-casks) INSTALL_CASKS=false ;;
    --no-remap) INSTALL_REMAP=false ;;
    --no-henry) INSTALL_HENRY=false ;;
    *) echo "unknown flag: $arg" && exit 1 ;;
  esac
done

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m ✓ \033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m ! \033[0m %s\n' "$*"; }
fail()  { printf '\033[1;31m ✗ \033[0m %s\n' "$*"; exit 1; }

[[ "$(uname -s)" == "Darwin" ]] || fail "This installer is macOS-only."
[[ -d "$DOTFILES" ]] || fail "Expected repo at ~/.dotfiles. Clone it there first."

# ----------------------
# 1. Xcode CLT + Homebrew
# ----------------------

info "Checking Xcode Command Line Tools"
if ! xcode-select -p >/dev/null 2>&1; then
  warn "Xcode CLT missing — launching installer. Re-run this script when it finishes."
  xcode-select --install
  exit 1
fi
ok "Xcode CLT installed"

info "Checking Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || fail "Homebrew install failed"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
ok "Homebrew: $(brew --version | head -1)"

# ----------------
# 2. Brew packages
# ----------------

FORMULAE=(tmux neovim fzf ripgrep fd eza sd sesh zoxide lazygit lazydocker gh node fnm)
info "Installing formulae: ${FORMULAE[*]}"
for f in "${FORMULAE[@]}"; do
  if brew list --formula "$f" >/dev/null 2>&1; then
    ok "$f (already installed)"
  else
    brew install "$f" && ok "$f" || warn "$f failed to install"
  fi
done

if $INSTALL_CASKS; then
  CASKS=(ghostty font-jetbrains-mono-nerd-font)
  info "Installing casks: ${CASKS[*]}"
  for c in "${CASKS[@]}"; do
    if brew list --cask "$c" >/dev/null 2>&1; then
      ok "$c (already installed)"
    else
      brew install --cask "$c" && ok "$c" || warn "$c failed to install (may already exist outside brew)"
    fi
  done
fi

# -------------
# 3. Submodules
# -------------

info "Ensuring git submodules (nvim, tmux, zsh) are initialized"
git -C "$DOTFILES" submodule update --init --recursive || fail "submodule init failed"
ok "Submodules ready"

# -----------
# 4. Symlinks
# -----------

info "Creating symlinks"
mkdir -p "$HOME/.config" "$HOME/.local"

backup() { # move a pre-existing real file/dir out of the way
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    warn "Backed up existing $(basename "$target") to $BACKUP_DIR"
  fi
}

link() {
  local src="$1" target="$2"
  backup "$target"
  ln -sfn "$src" "$target"
  ok "$target -> $src"
}

link "$DOTFILES/.zshenv"     "$HOME/.zshenv"
link "$DOTFILES/.tmux.conf"  "$HOME/.tmux.conf"
link "$DOTFILES/.fzf.zsh"    "$HOME/.fzf.zsh"
link "$DOTFILES/nvim"        "$HOME/.config/nvim"
link "$DOTFILES/tmux"        "$HOME/.config/tmux"
link "$DOTFILES/zsh"         "$HOME/.config/zsh"
link "$DOTFILES/ghostty"     "$HOME/.config/ghostty"
link "$DOTFILES/.local/bin"  "$HOME/.local/bin"

# ---------------
# 5. Zsh plugins
# ---------------

info "Pre-cloning zsh plugins"
for plugin in zsh-users/zsh-syntax-highlighting zsh-users/zsh-autosuggestions; do
  name="${plugin#*/}"
  dest="$DOTFILES/zsh/plugins/$name"
  if [[ -d "$dest" ]]; then
    ok "$name (already cloned)"
  else
    git clone --depth 1 "https://github.com/$plugin.git" "$dest" && ok "$name" || warn "$name clone failed"
  fi
done

# ---------------
# 6. tmux plugins
# ---------------

info "Installing tmux plugin manager + plugins"
if [[ ! -d "$TPM_DIR" ]]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR" || warn "tpm clone failed"
fi
if [[ -d "$TPM_DIR" ]]; then
  tmux start-server 2>/dev/null
  tmux new-session -d -s __bootstrap 2>/dev/null
  "$TPM_DIR/bin/install_plugins" >/dev/null 2>&1 && ok "tmux plugins installed" || warn "tpm install_plugins failed — run prefix+I inside tmux"
  tmux kill-session -t __bootstrap 2>/dev/null
fi

# -----------------
# 7. Neovim plugins
# -----------------

info "Bootstrapping Neovim plugins (lazy.nvim headless sync — this can take a minute)"
if nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1; then
  ok "Neovim plugins synced"
else
  warn "Headless Lazy sync reported errors — open nvim once to finish; LSPs install via Mason on first use"
fi

# --------------------------
# 8. Option -> Ctrl key remap
# --------------------------

if $INSTALL_REMAP; then
  info "Installing option->ctrl key remap (right option -> right control)"
  PLIST="$HOME/Library/LaunchAgents/com.larry-lime.remap-keys.plist"
  mkdir -p "$HOME/Library/LaunchAgents"
  cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.larry-lime.remap-keys</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/zsh</string>
    <string>$DOTFILES/scripts/on-login.sh</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF
  launchctl unload "$PLIST" 2>/dev/null
  launchctl load "$PLIST" 2>/dev/null && ok "LaunchAgent loaded (persists across reboots)" || warn "launchctl load failed"
  /bin/zsh "$DOTFILES/scripts/on-login.sh" >/dev/null && ok "Remap active now" || warn "hidutil remap failed"
fi

# ------------------------------
# 9. Henry work repo (worktrees)
# ------------------------------

if $INSTALL_HENRY; then
  info "Setting up ~/HenryLabs/henry worktrees (dev, main, staging, alpha..zeta)"
  if git ls-remote https://github.com/Henry-Social/henry >/dev/null 2>&1; then
    /bin/bash "$DOTFILES/scripts/setup-henry-worktrees.sh" || warn "henry worktree setup had issues — re-run scripts/setup-henry-worktrees.sh"
  else
    warn "Can't reach Henry-Social/henry (not authenticated?) — run 'gh auth login' then scripts/setup-henry-worktrees.sh"
  fi
fi

# ---------
# 10. Verify
# ---------

info "Verifying"
ERRORS=0
check() { # check <description> <command...>
  local desc="$1"; shift
  if "$@" >/dev/null 2>&1; then ok "$desc"; else warn "$desc FAILED"; ERRORS=$((ERRORS+1)); fi
}

for cmd in tmux nvim fzf rg fd eza sd sesh zoxide lazygit lazydocker fnm; do
  check "$cmd on PATH" command -v "$cmd"
done
check "~/.zshenv linked"           test -L "$HOME/.zshenv"
check "~/.config/zsh linked"       test -L "$HOME/.config/zsh"
check "~/.config/nvim linked"      test -L "$HOME/.config/nvim"
check "~/.config/tmux linked"      test -L "$HOME/.config/tmux"
check "~/.local/bin linked"        test -L "$HOME/.local/bin"
check "tpm installed"              test -d "$TPM_DIR"
check "zsh plugins cloned"         test -d "$DOTFILES/zsh/plugins/zsh-syntax-highlighting"
check "zsh config loads cleanly"   zsh -i -c exit
check "zsh prompt loads"           zsh -i -c 'whence git_info'
check "tmux config loads cleanly"  tmux -f "$HOME/.tmux.conf" new-session -d -s __verify
check "tmux prefix is C-f"         sh -c 'tmux show-option -g prefix | grep -q C-f'
tmux kill-session -t __verify 2>/dev/null
GHOSTTY_BIN="/Applications/Ghostty.app/Contents/MacOS/ghostty"
if [[ -x "$GHOSTTY_BIN" ]]; then
  check "ghostty config valid"     "$GHOSTTY_BIN" +validate-config
fi
if $INSTALL_HENRY && [[ -d "$HOME/HenryLabs/henry/dev" ]]; then
  check "henry worktrees present"  test -d "$HOME/HenryLabs/henry/main"
fi

echo
if [[ $ERRORS -eq 0 ]]; then
  ok "Done. Open a new terminal (or Ghostty) — zsh, tmux, and nvim are ready."
  echo "   Optional: drop ComicCodeLigatures Nerd Font .ttfs into ~/Library/Fonts (see README)."
else
  warn "Done with $ERRORS issue(s) — see warnings above."
fi
