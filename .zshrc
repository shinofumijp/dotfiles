alias ls="ls -GF"
alias ll='ls -lFG'
alias l='ls -lFG'
alias la='ls -lFGa'
alias vi='vim'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias be='bundle exec'
alias rm='rm -i'

alias k='kubectl'
alias kb='kustomize build'
alias kc='kubectx'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kns='kubens'
alias kex='kubectl exec'

alias sw-context='switch-k8s-context'
alias sw-ns='switch-k8s-namespace'

function switch-k8s-namespace() {
  kubens `kubens | peco`
}

function switch-k8s-context() {
    if [ $# -eq 1 ]; then
        if [ "$1" = "production" ]; then
            export KUBECONFIG=~/.kube/production.yaml
            echo 'Set KUBECONFIG to production'
        else
            export KUBECONFIG=~/.kube/config
            echo 'Set KUBECONFIG to staging'
        fi
        kubectx `kubectx | peco`
    else
        echo 'You must specify environment.\n'
        exit 1
    fi
}

# Only zsh
alias -g P='$(kubectl get pods | peco | awk "{print \$1}")'

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit
setopt auto_param_slash
unsetopt auto_remove_slash
setopt noautoremoveslash

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' special-dirs true

setopt no_beep

setopt auto_menu

setopt magic_equal_subst
setopt mark_dirs

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;34:ln=01;35:ex=01;32'

export LANG=ja_JP.UTF-8

PROMPT="%% "
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
export N_PREFIX=${HOME}/.n
export PATH=${HOME}/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:/usr/local/flutter/bin

export PATH=${N_PREFIX}/bin:$PATH
export PATH=$PATH:~/Library/Python/3.9/bin

export PATH="$HOME/.cargo/bin:$PATH"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

function kube_login_pod() {
    if [ $# -eq 1 ]; then
        kex -it -n $1 $(kg pod -n $1 | grep Running | sed -n 1p | awk "{print $1}") -- ash
    else
        echo 'You must specify namespace.\n'
        exit 1
    fi
}
