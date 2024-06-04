# bin/bash

install_packages_from_file() {
    FILE=$1
    pacman_pkgs=""
    pip_pkgs=""
    cargo_pkgs=""
    go_pkgs=""
    npm_pkgs=""

    while IFS= read -r line; do
        # skip comments
        if [[ $line == \#* ]]; then
            continue
        fi

        # check if line ends with "@pip", "@cargo", "@go" or nothing
        if [[ $line == *@pip ]]; then
            pip_pkgs+=" ${line%@pip}"
        elif [[ $line == *@cargo ]]; then
            cargo_pkgs+=" ${line%@cargo}"
        elif [[ $line == *@go ]]; then
            go_pkgs+=" ${line%@go}"
        elif [[ $line == *@npm ]]; then
            npm_pkgs+=" ${line%@npm}"
        else
            pacman_pkgs+=" $line"
        fi
    done <"$FILE"

    if [ -n "$pacman_pkgs" ]; then
        echo "Installing packages with pacman..."
        sudo pacman -S --noconfirm $pacman_pkgs
    fi

    if [ -n "$pip_pkgs" ]; then
        echo "Installing packages with pip..."
        pip install $pip_pkgs
    fi

    if [ -n "$cargo_pkgs" ]; then
        echo "Installing packages with cargo..."
        cargo install $cargo_pkgs
    fi

    if [ -n "$go_pkgs" ]; then
        echo "Installing packages with go..."
        go install $go_pkgs
    fi

    if [ -n "$npm_pkgs" ]; then
        echo "Installing packages with npm..."
        npm install -g $npm_pkgs
    fi
}

# Setup script for THE GIGA CLI
echo "Setting up THE GIGA CLI"

source "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

install_packages_from_file $PWD/gigacli/packages.txt

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo 'Installing mambaforge...'
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh

cp $HOME/secrets.sh $PWD/gigacli/secrets.sh

echo 'Installing zoxide...'
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# TODO: migrate ~/.config/emacs files into dotfiles
echo 'Installing doom emacs...'
git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
$HOME/.emacs.d/bin/doom install

echo 'Setting up atuin...'
mkdir -p ~/.local/share/atuin/
atuin init nu >~/.local/share/atuin/init.nu

echo 'Installing nix..'
sh <(curl -L https://nixos.org/nix/install) --daemon
