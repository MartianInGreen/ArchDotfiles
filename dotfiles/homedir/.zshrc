# If the session is interactive run the nsh command
# if [[ $- == *i* ]]; then
#     fastfetch --config $HOME/.config/fastfetch/config-tiny.jsonc && echo "Shell-GPT enabled. Use 'sgpt' to ask questions or 'sgpt -s' to execute commands."
# fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi 

# Source Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Powerlevel10k Prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
#zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::npm
zinit snippet OMZP::pip
zinit snippet OMZP::python
#zinit snippet OMZP::web-search

# Load autocompletion
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completions styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -la --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'exa -la --color=always $realpath'

zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' continuous-trigger 'tab'
zstyle ':fzf-tab:*' single-group ''

# Source the secrets
source ~/.secrets/secrets.zshrc

# Aliases 
alias ls='exa --color'
alias ll="exa -lah"

alias battery-info="upower -i /org/freedesktop/UPower/devices/battery_BAT1"

alias restart-cosmic-panel="pkill cosmic-panel & cosmic-panel &"

alias sync-nextcloud="systemctl --user start sync-folders"
alias sync-nextcloud-status="systemctl --user status sync-folders"
alias sync-nextcloud-logs="journalctl --user -u sync-folders.service"
alias sync-nextcloud-stop="systemctl --user stop sync-folders"
alias sync-nextcloud-restart="systemctl --user restart sync-folders"

alias disable-laptop-display="cosmic-randr disable eDP-1"
alias enable-laptop-display="cosmic-randr enable eDP-1"

alias start-default-network="sudo virsh net-list --all && sudo virsh net-start default"

alias start-on-gpu="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias load-nvidia-driver="sudo modprobe nvidia-drm"

alias giac="gitui && gia"
alias edit="cursor --ozone-platform-hint=wayland"

# Shell variables
export DISTROBOX_CUSTOM_HOME="$HOME/.containers"
export GNUPGHOME="$HOME/.secrets/"
export GPG_PINENTRY_MODE="loopback"

# Modify Path
PATH=$PATH:$HOME/.local/bin:$HOME/.scripts

# ---------------------------
# Tools
# ---------------------------

alias nvidia-driver-version="nvidia-smi | grep \"Driver Version\" | awk '{print $3}'"

alias update="archconfig system-update"

# ---------------------------
# Input Fixes
# ---------------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# ---------------------------
# Functions
# ---------------------------

# Shell integrations
if [[ -z "$DISTROBOX_ENTER_PATH" ]]; then
  eval "$(fzf --zsh)"
fi
eval "$(zoxide init --cmd cd zsh)"
