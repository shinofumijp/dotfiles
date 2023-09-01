#/bin/sh

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vimrc.keymap ~/.vimrc.keymap
if !(test -d ~/.vim); then
    mkdir ~/.vim
    if !(test -d ~/.vim/rc); then
        mkdir ~/.vimr/rc
    fi
fi
ln -sf ~/dotfiles/.vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/dotfiles/.vim/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -sf ~/dotfiles/.zprofile ~/.zprofile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gemrc ~/.gemrc
ln -sf ~/dotfiles/.brew/Brewfile ~/Brewfile
