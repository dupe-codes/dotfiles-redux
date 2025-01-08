export SHELL="/usr/bin/zsh"

# install plugins
source $HOME/.config/zsh/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle atuinsh/atuin@main
antigen apply

# setup path

prepend_path_if_not_exists() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

prepend_path_if_not_exists "/usr/local/bin"
prepend_path_if_not_exists "$HOME/.local/bin"
prepend_path_if_not_exists "$HOME/.cargo/bin"
prepend_path_if_not_exists "$HOME/go/bin"
prepend_path_if_not_exists "$HOME/.opam/default/bin"
prepend_path_if_not_exists "$HOME/.elan/bin"
prepend_path_if_not_exists "$HOME/.config/emacs/bin"
prepend_path_if_not_exists "$HOME/.ghcup/bin"
prepend_path_if_not_exists "$HOME/.cabal/bin"
prepend_path_if_not_exists "$HOME/.luarocks/bin"
export PATH

# setup environment variables and aliases

export EDITOR="nvim"
export BAT_THEME="tokyonight_night"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export RANGER_LOAD_DEFAULT_RC=false

source $HOME/shell.env

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias r='ranger'
alias pomodoro='arttime --nolearn -t "Get things done bruv" -a desktop -g "25m;30m;55m;1h;1h25m;1h30m;1h55m;2h25m;loop2"'
alias ll='exa -l -g --icons --git'
alias llt='exa -1 --icons --tree --git-ignore'
alias bonsai='cbonsai -L 42 --screensaver'
alias rss='nom'
alias weather='wthrr -u f,mph -f d,w'
alias hpie='/usr/bin/http'
alias c='clear'
alias s='search'
alias emacs='emacs -nw'
alias music='ncmpcpp'
alias ls=ll
alias open='xdg-open'
alias ocaml-env="opam switch && eval $(opam env)"
alias code="nap"
alias lzd="lazydocker"
alias lzg="lazygit"
alias gamevim="nvim --listen /tmp/godot.pipe"
alias mc="npm init @motion-canvas@latest"
alias anki='QT_XCB_GL_INTEGRATION=none anki'

# aliases for giga scripts
# TODO: automatically generate this with a ALIAS_name annotation in the scripts
alias tools='~/launcher.sh'
alias t='~/launcher.sh'
alias sesh='~/scripts/gigacli/tmux-sessionizer.sh'
alias sesh-tabbed="~/scripts/gigacli/tmux-sessionizer.sh; exit"
alias trash="~/scripts/gigacli/trash.sh"
alias tail-logs="$HOME/scripts/gigacli/tail-logs.sh"
alias quests="$HOME/scripts/gigabox/show-quests.sh"
alias commit='~/scripts/gigacli/commit.sh'
alias schedule='~/scripts/gigacli/schedule.sh'
alias timer='~/scripts/gigacli/timer.sh'
alias git-backup="$HOME/scripts/scheduled/backups-git.sh"

# git aliases
alias gp='git push'
alias gpl='git pull'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gch='git checkout'

# project setup aliases
alias godot_setup='~/scripts/gigacli/projects/godot_setup.sh'
alias lua_setup='~/scripts/gigacli/projects/lua_setup.sh'

# create util functions

remap() {
    sudo systemctl restart "$1-remap.service"
}

search() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf < /dev/null \
      --disabled --ansi --multi --reverse \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(down),border-sharp' \
      --query "$*"
)

# TODO: dynamically search the $HOME/scripts directory to find tool scripts
#       and create zsh aliases, except if there is a TOOL_EXCLUDE comment annotation
list-aliases() {
    alias | \
        awk -F'=' '{print $1 " => " substr($0, index($0, $2))}' | \
        fzf --reverse
}

# sourcegraph functionality
alias sg-launch="~/scripts/gigacli/launch_sg_docker.sh"
alias sg="open http://localhost:7080"

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
