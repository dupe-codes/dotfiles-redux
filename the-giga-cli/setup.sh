# Setup script for THE GIGA CLI
echo "Setting up THE GIGA CLI\n\n"

echo "Configuring kitty..."
ln -sf $PWD/kitty $HOME/.config/kitty

# TODO: Figure out how to congifure nushell in XDG_CONFIG_HOME
#       It will need to be copied because nushell doesn't seem to properly
#       work with symlinks
# echo "Configuring nushell..."

echo "Creating starship config symlink..."
ln -sf $PWD/nushell/starship.toml $HOME/.config/starship.toml

