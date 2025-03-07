local table_concat = require("dupe.util").table_concat

local plugins = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons", lazy = false },
    { "echasnovski/mini.icons", version = false },

    -- configure linting with null-ls
    {
        "nvimtools/none-ls.nvim",
        ft = { "python" },
        config = function()
            require "dupe.configs.none-ls"
        end,
    },

    -- code actions with lightbulb and menu
    {
        "kosayoda/nvim-lightbulb",
        lazy = false,
        dependencies = { "antoinemadec/FixCursorHold.nvim" },
        config = function()
            require "dupe.configs.lightbulb"
        end,
    },

    { "antoinemadec/FixCursorHold.nvim", lazy = false },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require "dupe.configs.lualine"
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require "dupe.configs.indent-blankline"
        end,
        lazy = false,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require "dupe.configs.treesitter"
        end,
    },
    { "sheerun/vim-polyglot" },
    { "nvim-lua/popup.nvim" },
    {
        "nvim-lua/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-frecency.nvim",
        },
        config = function()
            require "dupe.configs.telescope"
        end,
    },
    { "jremmen/vim-ripgrep" },
    { "preservim/nerdcommenter" },

    -- stats tracking
    { "wakatime/vim-wakatime", lazy = false },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require "dupe.configs.dashboard"
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },

    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "dnlhc/glance.nvim",
        config = function()
            require "dupe.configs.glance"
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "dupe.configs.harpoon2"
        end,
    },
    {
        "letieu/harpoon-lualine",
        dependencies = {
            { "ThePrimeagen/harpoon", branch = "harpoon2" },
        },
    },
    -- End Harpoon

    {
        "windwp/nvim-autopairs",
        lazy = false,
        config = true,
    },

    {
        "mbbill/undotree",
        config = function()
            require "dupe.configs.undotree"
        end,
    },

    -- Git plugins
    {
        "tpope/vim-fugitive",
        config = function()
            require "dupe.configs.git"
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "dupe.configs.gitsigns"
        end,
    },
    -- End git plugins

    {
        "folke/trouble.nvim",
        config = function()
            require "dupe.configs.trouble"
        end,
    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require "dupe.configs.todo-comments"
        end,
    },
    {
        "folke/zen-mode.nvim",
        dependencies = { "folke/twilight.nvim" },
        event = "VeryLazy",
        config = function()
            require "dupe.configs.zen-mode"
        end,
    },
    { "ThePrimeagen/vim-be-good", event = "VeryLazy" },

    -- Debugging plugins with dap
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope-dap.nvim",
            "folke/which-key.nvim",
        },
        config = function()
            require "dupe.configs.debugger"
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
    },
    {
        "mfussenegger/nvim-dap-python",
    },
    {
        "nvim-telescope/telescope-dap.nvim",
    },
    {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
    {
        "mxsdev/nvim-dap-vscode-js",
    },

    -- Cheatsheets and keybind hints
    {
        "folke/which-key.nvim",
        lazy = false,
        config = function()
            require "dupe.configs.which-key"
        end,
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        dependencies = {
            "nvim-lua/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require "dupe.configs.cheatsheet"
        end,
    },

    -- Package dependency management
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonInstallAll",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonUpdate",
            "MasonLog",
        },
        opts = {
            ensure_installed = {
                "bash-language-server",
                "black",
                "codelldb",
                "debugpy",
                "lua-language-server",
                "mypy",
                "pyright",
                "ruff",
                "rust-analyzer",
                "shellcheck",
                "shfmt",
                "zls",
                "clangd",
                "omnisharp",
                "csharpier",
                "stylua",
                "vtsls",
                "eslint-lsp",
                "prettierd",
                -- TODO: the version installed by mason is out of date and broken; re-enable
                --       here once latest gdtoolkit is available
                --       see https://github.com/Scony/godot-gdscript-toolkit/pull/259#issuecomment-2161503658
                -- "gdtoolkit",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            -- custom cmd to install listed mason binaries
            -- credit to NvChad :]
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})
            vim.g.mason_binaries_list = opts.ensure_installed
        end,
    },

    -- Color schemes
    {
        "zootedb0t/citruszest.nvim",
    },
    {
        "sam4llis/nvim-tundra",
    },
    {
        "sho-87/kanagawa-paper.nvim",
    },
    {
        "neanias/everforest-nvim",
        branch = "main",
    },
    {
        "folke/tokyonight.nvim",
        branch = "main",
    },
    { "rebelot/kanagawa.nvim" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" } },
    { "rose-pine/neovim", name = "rose-pine", lazy = false },
    { "ramojus/mellifluous.nvim" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "Yazeed1s/oh-lucy.nvim" },
    { "oxfist/night-owl.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "pineapplegiant/spaceduck", lazy = false, priority = 1000 },
    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
    },
    { "markvincze/panda-vim", lazy = false },
    { "decaycs/decay.nvim", name = "decay", lazy = false },
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
        config = true,
    },
    {
        "AlexvZyl/nordic.nvim",
    },
    {
        "embark-theme/vim",
        name = "embark",
    },
    {
        "b0o/lavi.nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "vague2k/vague.nvim",
    },
    {
        "wtfox/jellybeans.nvim",
        priority = 1000,
    },

    -- Zig support
    {
        "ziglang/zig.vim",
        ft = { "zig" },
        config = function()
            require "dupe.configs.zig"
        end,
    },

    -- tmux integration
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        config = function()
            require "dupe.configs.tmux-navigator"
        end,
    },

    {
        "smjonas/inc-rename.nvim",
        config = function()
            require "dupe.configs.inc-rename"
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        ft = { "rust" },
        config = function()
            require "dupe.configs.rust-tools"
        end,
    },

    -- Unit test runner support
    {
        "nvim-neotest/neotest",
        -- NOTE: add other langs as needed
        ft = { "python", "rust", "typescript", "javascript" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-vim-test",
            "marilari88/neotest-vitest",
            "vim-test/vim-test",
            "rouge8/neotest-rust",
        },
        config = function()
            require "dupe.configs.neotest"
        end,
    },

    -- notifications
    {
        "j-hui/fidget.nvim",
        lazy = false,
        config = function()
            require "dupe.configs.fidget"
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = false,
        config = function()
            require "dupe.configs.dressing"
        end,
    },
    {
        "AckslD/swenv.nvim",
        ft = { "python" },
        config = function()
            require "dupe.configs.swenv"
        end,
    },

    -- Symbols outline
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require "dupe.configs.symbols-outline"
        end,
    },

    -- Coq proof assistant
    {
        "whonore/Coqtail",
        ft = { "coq" },
        config = function()
            require "dupe.configs.coqtail"
        end,
    },
    --  TODO: add this back but change keybinds
    --        also scope to proof assistant files
    --        and/or latex/typst files
    -- { "joom/latex-unicoder.vim" },

    -- Lean theorem prover
    {
        "Julian/lean.nvim",
        event = { "BufReadPre *.lean", "BufNewFile *.lean" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
        },
    },

    -- better marks support
    {
        "chentoast/marks.nvim",
        config = function()
            require "dupe.configs.marks"
        end,
    },

    -- vim motions training
    --{
    --"m4xshen/hardtime.nvim",
    --dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --config = function()
    --require("dupe.configs.hardtime")
    --end,
    --},

    -- markdown rendering
    -- TODO: remove unused plugins
    --{ "ellisonleao/glow.nvim", config = true, cmd = "Glow"}
    --{
    --"MeanderingProgrammer/markdown.nvim",
    --name = "render-markdown",
    --dependencies = { "nvim-treesitter/nvim-treesitter" },
    --config = function()
    --require("render-markdown").setup {}
    --end,
    --},
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        config = function()
            require("markview").setup {}
        end,
    },

    -- Yank clipboard
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup()
        end,
    },

    -- Haskell tooling
    {
        "mrcjkb/haskell-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        version = "^2", -- Recommended
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    },

    {
        "stevearc/oil.nvim",
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require "dupe.configs.oil"
        end,
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },

    -- project note taking
    {
        "yujinyuz/gitpad.nvim",
        config = function()
            require "dupe.configs.gitpad"
        end,
    },

    -- sessions
    {
        "tpope/vim-obsession",
        config = function()
            require "dupe.configs.sessions"
        end,
    },

    -- show virtline counts of search matches
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require "dupe.configs.hlslens"
        end,
    },

    -- code actions preview
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        config = function()
            require "dupe.configs.code-action"
        end,
    },

    -- ide-like breadcrumbs
    {
        "Bekaboo/dropbar.nvim",
        config = function()
            require "dupe.configs.dropbar"
        end,
    },

    -- love game engine
    {
        "S1M0N38/love2d.nvim",
        ft = { "lua" },
        cmd = "LoveRun",
        config = function()
            require "dupe.configs.love"
        end,
    },

    -- snacks plugins
    {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            scratch = {
                enabled = true,
            },
        },
        keys = {
            {
                "<leader>-",
                function()
                    Snacks.scratch()
                end,
                desc = "toggle scratch buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "select scratch buffer",
            },
        },
    },
}

local modules = {
    "dupe.lsp",
    "dupe.completions",
    "dupe.format",
}

for _, module in ipairs(modules) do
    table_concat(plugins, require(module).plugins)
end

require("lazy").setup(plugins)
