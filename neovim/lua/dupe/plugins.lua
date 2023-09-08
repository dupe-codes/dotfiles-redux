local plugins = {
    { "zbirenbaum/copilot.lua", lazy = false, },
    { "nvim-lua/plenary.nvim", },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("dupe.configs.nvim-tree")
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = false },

    -- START: LSPs, completions, diagnostics
    { "onsails/lspkind-nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    -- configure linting with null-ls
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = {"python"},
        config = function()
            require("dupe.configs.null-ls")
        end,
    },
    -- code actions with lightbulb and menu
    {
        "kosayoda/nvim-lightbulb",
        lazy = false,
        dependencies = { "antoinemadec/FixCursorHold.nvim" },
        config = function()
            require("dupe.configs.lightbulb")
        end,
    },
     --END: LSPs, completions, diagnostics

    { "antoinemadec/FixCursorHold.nvim", lazy = false },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("dupe.configs.lualine")
        end
    },
    { "folke/neodev.nvim" },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("dupe.configs.indent-blankline")
        end,
        lazy = false
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("dupe.configs.treesitter")
        end
    },
    { "sheerun/vim-polyglot" }, -- TODO: needed?
    { "nvim-lua/popup.nvim" }, -- TODO: needed?
    {
        "nvim-lua/telescope.nvim",
        dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
        config = function()
            require("dupe.configs.telescope")
        end,
    },
    { "jremmen/vim-ripgrep" },
    {
        "romgrk/barbar.nvim",
        config = function()
            require("dupe.configs.barbar")
        end,
    },
    { "preservim/nerdcommenter" },
    { "wakatime/vim-wakatime", lazy = false },
    {
        "mhinz/vim-startify",
        config = function()
            require("dupe.configs.startify")
        end,
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "dnlhc/glance.nvim",
        config = function()
            require("dupe.configs.glance")
        end,
    },
    {
        "windwp/nvim-autopairs",
        --cond = function ()
            ---- disable autopairs for racket filetype
            --local filetype = vim.api.nvim_buf_get_option(0, "filetype")
            --return filetype ~= "racket"
        --end,
        config = function()
            require("dupe.configs.autopairs")
        end,
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("dupe.configs.harpoon")
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            require("dupe.configs.undotree")
        end,
    },

    -- Git plugins
    {
        "tpope/vim-fugitive",
        config = function()
            require("dupe.configs.git")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("dupe.configs.gitsigns")
        end,
    },
    -- End git plugins

    { "zbirenbaum/copilot-cmp" },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("dupe.configs.toggleterm")
        end,
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("dupe.configs.trouble")
        end,
    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("dupe.configs.todo-comments")
        end,
    },
    {
        "folke/zen-mode.nvim",
        dependencies = { "folke/twilight.nvim" },
        event = "VeryLazy",
        config = function()
            require("dupe.configs.zen-mode")
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
            require("dupe.configs.debugger")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
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
    { "folke/which-key.nvim", lazy = false },

    -- Package dependency management
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonInstallAll",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        opts = {
            ensure_installed = {
                "codelldb",
                "debugpy",
                "jdtls",
                "lua-language-server",
                "mypy",
                "pyright",
                "ruff",
                "rust-analyzer",
                "zls",
                "clangd",
                "ocaml-lsp",
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
        end
    },

    -- Color schemes
    { "cocopon/iceberg.vim" },
    {
        "neanias/everforest-nvim",
        branch = "main"
    },
    {
        "folke/tokyonight.nvim",
        branch = "main"
    },
    { "rebelot/kanagawa.nvim" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "mcchrish/zenbones.nvim" },
    { "rose-pine/neovim", name = "rose-pine", lazy = false },

    -- Zig support
    {
        "ziglang/zig.vim",
        ft = { "zig" },
        config = function()
            require("dupe.configs.zig")
        end,
    },

    -- tmux integration
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        config = function()
            require("dupe.configs.tmux-navigator")
        end,
    },

    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-lua/telescope.nvim",
        },
        config = function()
            require("dupe.configs.chatgpt")
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("dupe.configs.inc-rename")
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        ft = {"rust"},
        config = function()
            require('dupe.configs.rust-tools')
        end,
    },

    -- Unit test runner support
    {
        "nvim-neotest/neotest",
        ft = { "python", "rust", }, -- NOTE: add other langs as needed
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-vim-test",
            "vim-test/vim-test",
            "rouge8/neotest-rust",
        },
        config = function()
            require("dupe.configs.neotest")
        end,
    },

    -- notification
    {
        "rcarriga/nvim-notify",
        config = function()
            require("dupe.configs.notify")
        end,
    },
    {
        "stevearc/dressing.nvim",
        config = function()
            require("dupe.configs.dressing")
        end,
    },
    {
        "AckslD/swenv.nvim",
        ft = { "python" },
        config = function()
            require("dupe.configs.swenv")
        end,
    },
    -- Symbols outline
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("dupe.configs.symbols-outline")
        end,
    },
    -- Coq proof assistant
    {
        "whonore/Coqtail",
        config = function()
            require("dupe.configs.coqtail")
        end,
    },
    { "joom/latex-unicoder.vim" },
    -- Lean theorem prover
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
        }
    },
    -- better marks support
    {
        'chentoast/marks.nvim',
        config = function()
            require("dupe.configs.marks")
        end,
    },
    -- vim motions training
    {
       "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
       config = function()
           require("dupe.configs.hardtime")
       end,
    },
    -- markdown rendering
    { "ellisonleao/glow.nvim", config = true, cmd = "Glow"},

    {
        "xiyaowong/transparent.nvim",
        lazy = false,
    },
    -- racket lang support
    -- TODO: This caused errors, maybe conflict with nvim-autopairs
    --       Need to figure out how to disable autopairs on racket files
    --{
      --"gpanders/nvim-parinfer",
      --ft = { "racket" },
    --}
}

require("lazy").setup(plugins)

