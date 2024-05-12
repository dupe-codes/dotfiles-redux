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
export BAT_THEME="tokyonight_night"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export RANGER_LOAD_DEFAULT_RC=false

eval "$(github-copilot-cli alias -- "$0")"
source $HOME/secrets.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias code-i='code-insiders'
alias r='ranger'
alias gpt='chatblade -c 3.5 -s'
alias pomodoro='arttime --nolearn -t "Get things done bruv" -a desktop -g "25m;30m;55m;1h;1h25m;1h30m;1h55m;2h25m;loop2"'
alias ll='exa -l -g --icons --git'
alias llt='exa -1 --icons --tree --git-ignore'
alias gitui='gitui -t macchiato.ron'
alias bonsai='cbonsai -L 42 --screensaver'
alias rss='nom'
alias weather='wthrr -u f,mph -f d,w'
alias hpie='/usr/bin/http'
alias tools='~/launcher.sh'
alias t='~/launcher.sh'
alias c='clear'
alias s='search'
alias timer='~/scripts/gigacli/timer.sh'
alias emacs='emacs -nw'
alias music='ncmpcpp'
alias commit='~/scripts/gigacli/commit.sh'
alias schedule='~/scripts/gigacli/schedule.sh'
alias ls=ll
alias sesh='~/scripts/gigacli/tmux-sessionizer.sh'
alias open='xdg-open'
alias trash="~/scripts/gigacli/trash.sh"
alias quests="$HOME/scripts/gigabox/show-quests.sh"
alias ocaml-env="opam switch && eval $(opam env)"
alias code="nap"

search() {
  fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim
}

# Welcome message :]
echo -e "$(cat $HOME/posix-welcome.txt)"

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
