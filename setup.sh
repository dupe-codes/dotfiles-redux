# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# symlink config files
ln -sf ./dotfiles-redux/vimrc.vim $HOME/.config/nvim/vimrc.vim
ln -sf ./dotfiles-redux/init.lua $HOME/.config/nvim/init.lua

