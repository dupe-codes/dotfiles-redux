export SHELL="/usr/bin/zsh"

# install plugins
source $HOME/.config/zsh/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle atuinsh/atuin@main
antigen apply

prepend_path_if_not_exists() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

prepend_path_if_not_exists "/usr/local/bin"
prepend_path_if_not_exists "$HOME/.local/bin"
prepend_path_if_not_exists "$HOME/.cargo/bin"
prepend_path_if_not_exists "$HOME/Library/Application Support/carapace/bin"
prepend_path_if_not_exists "$HOME/go/bin"
prepend_path_if_not_exists "$HOME/.opam/default/bin"
prepend_path_if_not_exists "$HOME/.elan/bin"
prepend_path_if_not_exists "$HOME/.config/emacs/bin"
prepend_path_if_not_exists "$HOME/.ghcup/bin"
prepend_path_if_not_exists "$HOME/.cabal/bin"
export PATH

export EDITOR="nvim"
eval "$(github-copilot-cli alias -- "$0")"
source $HOME/secrets.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

giga() {
    if tmux list-sessions | grep -q "gigacli:"; then
        tmux attach-session -t gigacli
    else
        windows=("code" "terminal" "timer" "music")
        echo "Creating giga tmux session ..."

        tmux new-session -s gigacli -d -n "${windows[1]}"
        gum spin --spinner dot --title "Creating window '${windows[1]}' ..." -- sleep 0.8

        for window in ${windows[@]:1}; do
            tmux new-window -t gigacli -n "$window"
            gum spin --spinner dot --title "Creating window '$window' ..." -- sleep 0.8
        done

        tmux attach-session -t gigacli:1
    fi
}

# Welcome message :]
echo -e "$(cat $HOME/posix-welcome.txt)"

export CONDA_NO_PROMPT=true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dupe/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dupe/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/dupe/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/dupe/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

