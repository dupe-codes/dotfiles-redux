# Nushell Environment Config File
#
# version = 0.80.1

def create_left_prompt [] {
    mut home = ""
    try {
        if $nu.os-info.name == "windows" {
            $home = $env.USERPROFILE
        } else {
            $home = $env.HOME
        }
    }

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)/($path_color)"
}

def create_right_prompt [] {
    let time_segment_color = (ansi magenta)

    let time_segment = ([
        (ansi reset)
        $time_segment_color
        (date now | date format '%m/%d/%Y %r')
    ] | str join | str replace --all "([/:])" $"(ansi light_magenta_bold)${1}($time_segment_color)" |
        str replace --all "([AP]M)" $"(ansi light_magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

##### Environment Variable Configuration #####

def prepend-if-not-exists [curr_path path_to_prepend] {
    if $path_to_prepend in $curr_path {
        $curr_path
    } else {
        $curr_path | prepend $path_to_prepend
    }
}

# TODO: carrapace path is homebrew specific - generalize it
# NOTE: The conda nushell script will also prepend mambaforge,
#       but its invocations of conda fail without including it in the path
#       here to start so... whatevs, we have multiple mambas. nbd.
$env.PATH = (
    $env.PATH |
    split row (char esep) |
    prepend-if-not-exists $in "/usr/local/bin/" |
    prepend-if-not-exists $in $"($env.HOME)/.local/bin" |
    prepend-if-not-exists $in $"($env.HOME)/.cargo/bin" |
    prepend-if-not-exists $in $"($env.HOME)/Library/Application Support/carapace/bin" |
    prepend-if-not-exists $in $"($env.HOME)/mambaforge/bin" |
    prepend-if-not-exists $in $"($env.HOME)/go/bin" |
    prepend-if-not-exists $in $"($env.HOME)/.opam/default/bin" |
    prepend-if-not-exists $in $"($env.HOME)/.elan/bin" |
    prepend-if-not-exists $in $"($env.HOME)/.config/emacs/bin" |
    prepend-if-not-exists $in $"($env.HOME)/.ghcup/bin" |
    prepend-if-not-exists $in $"($env.HOME)/.cabal/bin"
)

# CLI tool configurations
$env.BAT_THEME = "tokyonight_night"
$env.FZF_DEFAULT_OPTS = "--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

$env.SHELL = "/usr/bin/nu"
$env.EDITOR = "nvim"
$env.RANGER_LOAD_DEFAULT_RC = false

# Conda/mamba configurations
$env.CONDA_NO_PROMPT = true

# TODO: Re-enable this after next zoxide release fixes nushell compatability
# zoxide init nushell | save -f ~/.zoxide.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Configure opam env
# TODO: Figure out how to get better support for opam switches
$env.OPAM_SWITCH_PREFIX = $"($env.HOME)/.opam/default"
$env.CAML_LD_LIBRARY_PATH = $"($env.HOME)/.opam/default/lib/stublibs:/usr/lib/ocaml/stublibs:/usr/lib/ocaml"
$env.OCAML_TOPLEVEL_PATH = $"($env.HOME)/.opam/default/lib/toplevel"
$env.MANPATH = $":($env.HOME)/.opam/default/man"

