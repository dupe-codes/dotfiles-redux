#!/usr/bin/env bash

install_packages() {
    PACKAGES_FILE=$1

    pacman_pkgs=""
    yay_pkgs=""
    cargo_pkgs=""
    pip_pkgs=""
    go_pkgs=""
    npm_pkgs=""

    parse_section() {
        local section=$1

        packages=$(yq eval ".${section} | keys" -o csv "$PACKAGES_FILE" | tr -d '"' | tr ',' ' ')

        for package in $packages; do
            version=$(yq eval ".${section}.${package}" "$PACKAGES_FILE")
            if [ "$version" == "latest" ]; then
                case $section in
                "default") pacman_pkgs+=" $package" ;;
                "yay") yay_pkgs+=" $package" ;;
                "cargo") cargo_pkgs+=" $package" ;;
                "pip") pip_pkgs+=" $package" ;;
                "go") go_pkgs+=" $package@latest" ;;
                "npm") npm_pkgs+=" $package" ;;
                esac
            else
                case $section in
                "default") pacman_pkgs+=" $package=$version" ;;
                "yay") yay_pkgs+=" $package=$version" ;;
                "cargo") cargo_pkgs+=" $package --version $version" ;;
                "pip") pip_pkgs+=" $package==$version" ;;
                "go") go_pkgs+=" $package@$version" ;;
                "npm") npm_pkgs+=" $package@$version" ;;
                esac
            fi
        done
    }

    parse_section "default"
    parse_section "yay"
    parse_section "cargo"
    parse_section "pip"
    parse_section "go"
    parse_section "npm"

    if [ -n "$pacman_pkgs" ]; then
        echo "Installing packages with pacman..."
        sudo pacman -S --noconfirm "$pacman_pkgs"
    fi

    if [ -n "$yay_pkgs" ]; then
        echo "Installing packages with yay..."
        yay -S --noconfirm "$yay_pkgs"
    fi

    if [ -n "$pip_pkgs" ]; then
        echo "Installing packages with pip..."
        pip install "$pip_pkgs"
    fi

    if [ -n "$cargo_pkgs" ]; then
        echo "Installing packages with cargo..."
        cargo install "$cargo_pkgs"
    fi

    if [ -n "$go_pkgs" ]; then
        echo "Installing packages with go..."
        go install "$go_pkgs"
    fi

    if [ -n "$npm_pkgs" ]; then
        echo "Installing packages with npm..."
        npm install -g "$npm_pkgs"
    fi
}

# Setup script for THE GIGA CLI
echo "Setting up THE GIGA CLI"

source "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

install_packages "$PWD"/gigacli/packages.txt

git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm

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
