# TEMP
source ~/.zprofile

# Appearance
autoload -U colors && colors
source $ZDOTDIR/prompt.zsh

# History
HISTSIZE=100000
SAVEHIST=100000
ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE
HISTFILE="$ZSH_CACHE/history"
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history

# Autocomplete
setopt always_to_end #move cursor to the end of the word    
setopt auto_menu # show completion menu on successive tab press
setopt auto_name_dirs
setopt complete_in_word # Allow completion from within a word/phrase

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"


# Keys that don't work
bindkey -e
bindkey "\e[3~" delete-char # Delete key
bindkey ' ' magic-space
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Have better WORDCHARS
export WORDCHARS="_"

# Aliases
alias ls='exa'
alias ll='exa -lh'
alias la='exa -a'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

alias copy='xclip -sel clip'

alias g='git'

alias cal='LC_TIME=en_US.UTF-8 cal --monday'

alias newjacksink='pactl load-module module-jack-sink client_name=pulse_sink_2 connect=yes'

# Plugins
source "$DOTFILES/zgen/zgen.zsh"
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search

    zgen save
fi

# Search history with Up and Down arrows
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Make history search not highlight anything
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=""
alias sourcenvm='source /usr/share/nvm/init-nvm.sh'
