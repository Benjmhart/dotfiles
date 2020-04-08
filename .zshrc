# this lives in ~/.zshrc
# If you come from bash you might have to change your $PATH.
source /etc/profile
export PATH=$HOME/bin:/usr/local/bin:$PATH:/bin:/usr/bin:/usr/local/bin:${PATH}:/$HOME/.local/bin:$HOME/.cabal/config:$HOME/.zshscripts:$HOME/.nvm:/snap/bin:$HOME/.stack:$HOME/go/bin:$HOME/.cargo/bin
if  [ -f /home/ben/.nix-profile/etc/profile.d/nix.sh ] ; then
  . /home/ben/.nix-profile/etc/profile.d/nix.sh
fi

export WINHOME=/mnt/c/Users/Ben

autoload -Uz compinit
compinit

export XDG_CONFIG_HOME=$HOME/.configure
export XDG_CACHE_HOME=$HOME/.cache

export EDITOR=/bin/nvim
export BROWSER=/usr/bin/qutebrowser

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

#GOPATH
export GOPATH=~/Projects/go

if [[ -d "$HOME/.nvm" ]]
then
  source "$HOME/.nvm/nvm.sh"
else
  source "$HOME/.configure/nvm/nvm.sh"
fi
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="kolo" # also see kolo, robbyrussel, miloshadzic, simple

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(gitfast command-not-found compleat npm cabal sudo vscode zsh-syntax-highlighting vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# AutoResolve Aliases
expand-aliases() {
  unset 'functions[_expand-aliases]'
  functions[_expand-aliases]=$BUFFER
  (($+functions[_expand-aliases])) &&
    BUFFER="${functions[_expand-aliases]#$'\t'}" &&
    CURSOR=$#BUFFER
}

zle -N expand-aliases
bindkey '^ ' expand-aliases

# vim keybindings
bindkey -v

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


# vim mode switch delay
export KEYTIMEOUT=1
# see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode for mapping details

# allow 256 colors in konsole
export COLORTERM=truecolor

# Example aliases
alias zshrc="nvim ~/.zshrc"
alias cd..="cd .."
alias setmon3="$HOME/.screenlayout/tripleThreat.sh"
alias setmon1="$HOME/.screenlayout/single.sh"
alias setmonwide="$HOME/.screenlayout/wide.sh"
alias start3="$HOME/bin/start3.sh"
alias start1="$HOME/bin/start1.sh"
alias startwide="$HOME/bin/startwide.sh"
alias projects="cd ~/Projects"
alias reload="source ~/.zshrc"
alias dotfiles="cd ~/dotfiles"
alias mongostart="docker run -d -p 27017-27019:27017-27019 --name mongod mongo"
alias mongod="docker start mongod"
alias mongo="docker exec -it mongod bash"
alias gitchron="git branch --sort=committerdate"
alias nvimrc="nvim ~/.configure/nvim/init.vim"
alias xampp="sudo /opt/lampp/manager-linux-x64.run"
alias capset="xmodmap ~/.Xmodmap"
alias rng="ranger"
alias please='sudo $(fc -ln -1)'
alias singletray="stalonetray --config ~/.stalonetrayrc-single"
alias tmux="tmux -u"
alias clipdelete="clipmenu | clipdel -d --exact-match"
unalias la
alias la="ls -a"
alias clip="xclip -sel clip"
alias vimrc="nvim ~/.configure/nvim/init.vim"
alias localec="LC_ALL='C'"
alias localen="LC_ALL='en_US.UTF-8'"
eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
