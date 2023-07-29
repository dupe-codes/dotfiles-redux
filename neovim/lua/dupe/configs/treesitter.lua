require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'python',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'yaml',
        'scala',
        'terraform',
        'clojure',
        'markdown',
        'zig',
    },
    highlight = {
        enable = true,
    }
}

require('treesitter-context').setup {
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

local hl = vim.api.nvim_set_hl
hl(0, "TreesitterContext", { link = 'PMenu' })

