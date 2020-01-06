if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init - zsh)"; fi

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init - zsh)"
