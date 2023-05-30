# Smooth setup of a smooth developer environment :]

## TODO:

1. Set up preferred base conda environment.yaml for jupyter notebook environments
    - Include jupyter, notebook extensions, RISE (slideshows), jupyterthemes, etc.
2. Set up installs and configurations for nnn in install script
3. Figure out better install setup for zsh-z
4. Add dropbar plugin to neovim once nvim-nightly isn't required

# Tools Index

1. nnn - terminal file manager

# Notes

## pre-commit hooks
1. Copy .pre-commit-config.yaml file to project root directory
2. For c/c++ projects, copy .clang-format file to project root directory
3. In project root directory, execute `pre-commit install` to configure hooks

## C++ project setup
1. Copy `project-configs/CMakeLists.base.txt` to project root
2. Copy `project-configs/.ccls` to project root to configure ccls language server
3. After configuring CMake files, from project root execute:
    ```
    mkdir build
    cd build
    cmake_init # alias for 'CC=clang CXX=g++-13 cmake ..'
    ```

