if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init - zsh)"
