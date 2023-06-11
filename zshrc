export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="amuse"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting history)
source $ZSH/oh-my-zsh.sh

# Completions settings
# --------------------
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# source z completions
. ~/z.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dupe/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dupe/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/dupe/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dupe/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/dupe/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/dupe/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export EDITOR="nvim"

alias nnn="tmux new -s nnn_session \"nnn -ea -P p\""
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='p:preview-tui'
export NNN_ICONLOOKUP=1

eval "$(github-copilot-cli alias -- "$0")"

alias pep8="find . -name \"*.py\" | xargs autopep8 -i"
alias cpp="g++-13"
alias cmake_init="CC=clang CXX=g++-13 cmake .."

# arttime pomodoro command
alias pomodoro="arttime --nolearn -t \"Get things done bruv\" -a desktop -g \"25m;30m;55m;1h;1h25m;1h30m;1h55m;2h25m;loop2\""

# Source secrets env vars
source $HOME/secrets.sh

# alias for chatblade gpt usage
# TODO: Add saved developer assistant prompt
alias gpt="chatblade -c 3.5 -s"

# Welcome message :]
echo -e "$(cat $HOME/gundam.txt)"

# Update PATH for riscv toolchain (OS course)
PATH=$PATH:/usr/local/opt/riscv-gnu-toolchain/bin

# Add fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fsearch="fzf --preview \"bat --color=always --style=header,grid --line-range :500 {}\""

