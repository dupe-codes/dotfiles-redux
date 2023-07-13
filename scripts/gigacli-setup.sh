# bin/bash

install_packages_from_file() {
    FILE=$1
    pacman_pkgs=""
    pip_pkgs=""
    cargo_pkgs=""
    go_pkgs=""

    while IFS= read -r line
    do
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
}

# Setup script for THE GIGA CLI
echo "Setting up THE GIGA CLI\n\n"

install_packages_from_file $PWD/gigacli/packages.txt

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo 'Installing mambaforge...'
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh

