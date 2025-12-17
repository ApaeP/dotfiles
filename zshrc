# ══════════════════════════════════════════════════════════════════════════════
# Oh-My-Zsh
# ══════════════════════════════════════════════════════════════════════════════

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"  # https://github.com/robbyrussell/oh-my-zsh/wiki/themes

plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search)

source "${ZSH}/oh-my-zsh.sh"

unalias rm  # No interactive rm by default (brought by plugins/common-aliases)

# ══════════════════════════════════════════════════════════════════════════════
# Environment Variables
# ══════════════════════════════════════════════════════════════════════════════

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1
export COMPOSE_BAKE=true
export BUNDLER_EDITOR="cursor --wait"
export EDITOR="cursor --wait"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl) --with-readline-dir=$(brew --prefix readline)"

# ══════════════════════════════════════════════════════════════════════════════
# PATH (ordre inverse : le dernier ajouté a la priorité)
# ══════════════════════════════════════════════════════════════════════════════

# Tools (priorité basse)
export PATH="/Users/paulportier/.codeium/windsurf/bin:$PATH"
export PATH="$(brew --prefix bison)/bin:$PATH"

# Databases
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Languages / Package managers
export PATH="/anaconda3/bin:${HOME}/anaconda3/bin:${PATH}"
export PATH="${HOME}/.rbenv/bin:${PATH}"

# Local bin folders (priorité haute - binstubs Rails, node_modules)
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# ══════════════════════════════════════════════════════════════════════════════
# Version Managers
# ══════════════════════════════════════════════════════════════════════════════

# rbenv
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init - 2> /dev/null)" && RPROMPT+='[🐍 $(pyenv version-name)]'``
# Set ipdb as the default Python debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# nvm
autoload -U add-zsh-hook
load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# ══════════════════════════════════════════════════════════════════════════════
# SSH & Keychain
# ══════════════════════════════════════════════════════════════════════════════

ssh-add --apple-use-keychain > /dev/null 2>&1

# ══════════════════════════════════════════════════════════════════════════════
# Google Cloud SDK
# ══════════════════════════════════════════════════════════════════════════════

[ -f '/Users/paulportier/Downloads/google-cloud-sdk/path.zsh.inc' ] && . '/Users/paulportier/Downloads/google-cloud-sdk/path.zsh.inc'
[ -f '/Users/paulportier/Downloads/google-cloud-sdk/completion.zsh.inc' ] && . '/Users/paulportier/Downloads/google-cloud-sdk/completion.zsh.inc'

# ══════════════════════════════════════════════════════════════════════════════
# Aliases
# ══════════════════════════════════════════════════════════════════════════════

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# ══════════════════════════════════════════════════════════════════════════════
# Cleanup
# ══════════════════════════════════════════════════════════════════════════════

typeset -U path
