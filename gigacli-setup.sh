# Setup script for THE GIGA CLI
echo "Setting up THE GIGA CLI\n\n"

echo "Configuring kitty..."
ln -sf $PWD/the-giga-cli/kitty $HOME/.config/

# TODO: Figure out how to congifure nushell in XDG_CONFIG_HOME
#       It will need to be copied because nushell doesn't seem to properly
#       work with symlinks
#       Also git clone nu_scripts into nushell config dir
echo "Configuring nushell..."
cp $PWD/the-giga-cli/nushell/nu-welcome.txt $HOME/nu-welcome.txt
echo "Remember to configure your secrets.nu file!"

echo "Creating starship config symlink..."
ln -sf $PWD/the-giga-cli/nushell/starship.toml $HOME/.config/

echo "Configuring tmux..."
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ln -sf $PWD/the-giga-cli/tmux $HOME/.config/

# TODO: Install packages from packages.txt
#       Split between brew/cargo/other based on comment headers
#       Set package manager based on OS; e.g., brew for macOS, 
#       pacman for arch linux

# TODO: Install mambaforge

