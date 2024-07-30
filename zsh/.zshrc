# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Init ZINIT
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"



# Plugins
# light insted of load loads without reporting/investigating.
# snippet <URL> used to source remote script
# ice _lots of options_ load after start
# Must be first
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# To load bindings after zsh-vi-mode
function zvm_after_init() {
  zinit light Aloxaf/fzf-tab
  # Used tmux pop-up
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  bindkey '^ ' autosuggest-accept
  bindkey '^p' history-search-backward
  bindkey '^n' history-search-forward
}


# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# zsh-vi-mode
# vv to edit prompt in $ZVM_VI_EDITOR
export ZVM_VI_EDITOR=nvim

# Classic mode
# S" : Add " in **visual selection**
# ys" : Add " in **visual selection**
# cs"' : Change " to '
# ds" : Delete "
export ZVM_VI_SURROUND_BINDKEY=classic

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Load completions
autoload -Uz compinit && compinit

# Path additions
PATH=$PATH:~/go/bin/


# TODO move alias to ~/.zshenv
# Turn off all beeps
unsetopt BEEP
alias vi=nvim
# Turn off autocomplete beeps
# unsetopt LIST_BEEP

# Aliases
alias ls="ls --color"

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init zsh --cmd cd)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
