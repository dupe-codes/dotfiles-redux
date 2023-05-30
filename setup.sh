# Install brew packages from brew.txt
<brew.txt xargs brew install

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# symlink config files
mkdir -p $HOME/.config/nvim

cp ./ascii-art.txt $HOME/.config/nvim/ascii-art.txt

ln -sf ./vimrc.vim $HOME/.config/nvim/vimrc.vim
ln -sf ./init.lua $HOME/.config/nvim/init.lua
ln -s ./zshrc $HOME/.zshrc

# symlink clang tooling
ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"

# install mambaforge
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh

