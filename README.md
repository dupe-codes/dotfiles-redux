# Smooth setup of a smooth developer environment :]

# Notes

## pre-commit hooks
1. Copy .pre-commit-config.yaml file to project root directory
2. For c/c++ projects, copy .clang-format file to project root directory
3. In project root directory, execute the following to configure hooks:

```bash
pre-commit install
pre-commit install -t prepare-commit-msg
```

## C++ project setup
1. Copy `project-configs/CMakeLists.base.txt` to project root
2. Copy `project-configs/.ccls` to project root to configure ccls language server
3. After configuring CMake files, from project root execute:
    ```
    CC=clang CXX=g++-13 cmake -S . -B build/debug -DCMAKE_BUILD_TYPE=DEBUG
    CC=clang CXX=g++-13 cmake -S . -B build/release -DCMAKE_BUILD_TYPE=RELEASE
    ```
    The first command creates a debug target, the second is a release target
