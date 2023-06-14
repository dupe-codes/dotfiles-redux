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
    { "sheerun/vim-polyglot" },
    { "jmbuhr/otter.nvim" },
    { "nvim-lua/popup.nvim" },
    {
        "nvim-lua/telescope.nvim",
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
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("dupe.configs.linting")
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
    {
        "tpope/vim-fugitive",
        config = function()
            require("dupe.configs.fugitive")
        end,
    },
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
        config = function()
            require("dupe.configs.zen-mode")
        end,
    },
    { "ThePrimeagen/vim-be-good" },

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
                "jdtls",
                "lua-language-server",
                "pyright",
                "rust-analyzer",
                "zls",
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
    --{
        --"WhoIsSethDaniel/mason-tool-installer.nvim",
        --depends = { "williamboman/mason.nvim" },
        --config = function()
            --require("dupe.configs.mason-tools")
        --end,
    --},

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
        config = function()
            require("dupe.configs.zig")
        end,
    },
}

require("lazy").setup(plugins)

