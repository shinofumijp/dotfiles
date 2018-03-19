alias ls="ls -GF"
alias ll='ls -lFG'
alias l='ls -lFG'
alias la='ls -lFGa'
alias vi='vim'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias be='bundle exec'
alias rm='rm -i'

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit
setopt auto_param_slash
unsetopt auto_remove_slash
setopt noautoremoveslash

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

setopt no_beep

setopt auto_menu

setopt magic_equal_subst
setopt mark_dirs

export LS_COLORS='di=01;36'
export LANG=ja_JP.UTF-8

PROMPT="%m:%n%% "
RPROMPT="[%~]"
SPROMPT="correct: %R -> %r ? "

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function lprompt-git-current-branch {
local name st color gitdir action
if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
fi
name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
if [[ -z $name ]]; then
    return
fi

gitdir=`git rev-parse --git-dir 2> /dev/null`
action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

st=`git status 2> /dev/null`
color=%F{green}

echo "[$color$name$action%f%b] "
}

PROMPT+='`lprompt-git-current-branch`'
export GOPATH=~/dev/go
export RBENV_ROOT=${HOME}/.rbenv
export PATH=${HOME}/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/bin
export PATH=${HOME}/.cabal/bin:${PATH}
export PATH=$HOME/.nodebrew/current/bin:$PATH

# added by travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
