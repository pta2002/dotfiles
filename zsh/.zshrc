# TEMP
source ~/.zprofile

# Source a plugin manager
source "$DOTFILES/zgen/zgen.zsh"

# Appearance
autoload -U colors && colors
source $ZDOTDIR/prompt.zsh

# History
HISTSIZE=10000
SAVEHIST=10000
ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE
HISTFILE="$ZSH_CACHE/history"
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history

# Search history with Up and Down arrows
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Autocomplete
setopt always_to_end #move cursor to the end of the word    
setopt auto_menu # show completion menu on successive tab press
setopt auto_name_dirs
setopt complete_in_word # Allow completion from within a word/phrase

# Keys that don't work
bindkey -e
bindkey "\e[3~" delete-char # Delete key
bindkey ' ' magic-space
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Have better WORDCHARS
export WORDCHARS="_"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zsh-users/zsh-syntax-highlighting

    zgen save
fi
