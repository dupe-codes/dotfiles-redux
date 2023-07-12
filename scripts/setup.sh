# TODO: Move most of this into the gigacli setup script
#       Only the font download and setup should go in the gigabox 
#       setup script

# Install brew packages from brew.txt
echo 'Installing brew packages from packages.txt...'
<packages.txt xargs brew install

# symlink config files
echo 'Setting up neovim config files...'
mkdir -p $HOME/.config/nvim

# configure to copy desired ascii art to nvim; default to 2B
cp $PWD/ascii-art/ascii-art-2b.txt $HOME/.config/nvim/ascii-art.txt
cp $PWD/ascii-art/gundam.txt $HOME/gundam.txt

# symlink neovim configs
ln -sf $PWD/neovim/init.lua $HOME/.config/nvim/init.lua
ln -sf $PWD/neovim/lua $HOME/.config/nvim/

# pull patched berkeley mono fonts from Dropbox
# Patched following instructions at
# https://tech.serhatteker.com/post/2023-04/patch-berkeley-mono-font-with-nerd-fonts/
mkdir -p $PWD/fonts/
curl -L -o $PWD/fonts/berkeley-mono-nerd-font.zip "https://www.dropbox.com/s/wvmpjlsht24ol5j/berkeley-mono-nerd-font.zip?dl=0"
unzip $PWD/fonts/berkeley-mono-nerd-font.zip -d $PWD/fonts/
echo "Berkeley Mono Nerd Font downloaded and unzipped. Please install manually."

# symlink zshrc
echo 'Setting up zshrc... Remember to fill in secrets.sh!'
ln -s $PWD/zshrc $HOME/.zshrc
cp $PWD/secrets.sh $HOME/secrets.sh

# symlink clang tooling
echo 'Setting up clang tooling...'
ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"

# install mambaforge
echo 'Installing mambaforge...'
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh

# symlink devmoji config to home dir
ln -sf $PWD/project-configs/devmoji.config.js $HOME/devmoji.config.js

