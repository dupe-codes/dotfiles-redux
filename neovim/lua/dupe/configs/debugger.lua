local dap = require "dap"
local dap_virtual_text_status = require "nvim-dap-virtual-text"
local dapui = require "dapui"

dap_virtual_text_status.setup {
    commented = true,
}

dapui.setup {
    layouts = {
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 0.2,
            position = "left",
        },
        {
            elements = {
                "repl",
            },
            size = 0.3,
            position = "bottom",
        },
    },
    controls = {
        enabled = true,
    },
    render = {
        max_value_lines = 3,
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
}

local icons = {
    ui = {
        TinyCircle = "●",
        CircleWithGap = "○",
        ChevronRight = "▶",
        LogPoint = "◉",
    },
    Error = "",
}

vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
vim.fn.sign_define("DapBreakpoint", {
    text = icons.ui.TinyCircle,
    texthl = "DapBreakpoint",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapBreakpointCondition", {
    text = icons.ui.CircleWithGap,
    texthl = "DapBreakpointCondition",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapLogPoint", {
    text = icons.ui.LogPoint,
    texthl = "DapLogPoint",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapStopped", {
    text = icons.ui.ChevronRight,
    texthl = "Error",
    linehl = "DapStoppedLinehl",
    numhl = "",
})
vim.fn.sign_define("DapBreakpointRejected", {
    text = icons.ui.Error,
    texthl = "Error",
    linehl = "",
    numhl = "",
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Debugging packages installation folder
local install_root_dir = vim.fn.stdpath "data" .. "/mason"

--#region
-- Setup debug adapters

-- Python adapter
-- requires debugpy installation
local debugpy_path = install_root_dir .. "/packages/debugpy/venv/bin/python"
require("dap-python").setup(debugpy_path)

function find_django_manage_file()
    -- search for manage.py in current directory and all subdirectories
    local manage_files = vim.fn.globpath(".", "**/manage.py", false, true)
    if manage_files == nil or #manage_files == 0 then
        return ""
    end
    return manage_files[1]
end

table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "Run Django server",
    program = function()
        return vim.fn.getcwd() .. "/" .. find_django_manage_file()
    end,
    args = { "runserver", "0.0.0.0:8000", "--noreload" },
})

-- Javascript & Typescript configuration
-- TODO: configure for debugging client side JS by connecting to chrome browser

local vscode_js_debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug")
require("dap-vscode-js").setup {
    debugger_path = vscode_js_debugger_path,
    adapters = { "pwa-node" },
}

for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
    }
end

-- Rust adapter
-- DAP settings from https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
-- config: https://github.com/simrat39/rust-tools.nvim/blob/master/lua/rust-tools/dap.lua
local extension_path = install_root_dir .. "/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    host = "127.0.0.1",
    executable = {
        command = codelldb_path,
        args = { "--liblldb", liblldb_path, "--port", "${port}" },
    },
}

local rust_dap_config = {
    name = "Rust debug",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = {}, -- TODO: figure out how to pass args
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
}

dap.configurations.rust = { rust_dap_config }

-- c++ adapter
-- Also used codelldb, only need to create config

local cpp_dap_config = {
    name = "C++ Debug And Run",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
}
dap.configurations.cpp = { cpp_dap_config }

-- c adapter
-- uses codelldb, only need config

local c_dap_config = {
    name = "C Debug And Run",
    type = "codelldb",
    request = "launch",
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
}
dap.configurations.c = { c_dap_config }

-- godot adapter and configuration

dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
}

-- see the godot vscode plugin README for more configuration options:
-- https://github.com/godotengine/godot-vscode-plugin#configurations
dap.configurations.gdscript = {
    {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
    },
}

-- lua and LOVE

dap.adapters["local-lua"] = {
    type = "executable",
    command = "local-lua-dbg",
    enrich_config = function(config, on_config)
        if not config["extensionPath"] then
            local c = vim.deepcopy(config)
            c.extensionPath = "/usr/lib/node_modules/local-lua-debugger-vscode/"
            on_config(c)
        else
            on_config(config)
        end
    end,
}

dap.configurations.lua = {
    {
        name = "Current file (local-lua-dbg, lua)",
        type = "local-lua",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = {
            lua = "lua",
            file = "${file}",
        },
    },
}

--#endregion

--#region
-- Setup debugging keymaps

local whichkey = require "which-key"

whichkey.setup {
    ignore_missing = true, -- only have whichkey enabled for debug keymaps
}

local keymap = {
    { "<leader>d", group = "debug", nowait = false, remap = false },
    {
        "<leader>dC",
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
        desc = "Conditional Breakpoint",
        nowait = false,
        remap = false,
    },
    {
        "<leader>dE",
        "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
        desc = "Evaluate Input",
        nowait = false,
        remap = false,
    },
    {
        "<leader>dR",
        "<cmd>lua require'dap'.run_to_cursor()<cr>",
        desc = "Run to Cursor",
        nowait = false,
        remap = false,
    },
    { "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", desc = "Scopes", nowait = false, remap = false },
    { "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI", nowait = false, remap = false },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", nowait = false, remap = false },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = false, remap = false },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", nowait = false, remap = false },
    { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Evaluate", nowait = false, remap = false },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", nowait = false, remap = false },
    {
        "<leader>dh",
        "<cmd>lua require'dap.ui.widgets'.hover()<cr>",
        desc = "Hover Variables",
        nowait = false,
        remap = false,
    },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = false, remap = false },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = false, remap = false },
    { "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", desc = "Pause", nowait = false, remap = false },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", nowait = false, remap = false },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = false, remap = false },
    { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", nowait = false, remap = false },
    {
        "<leader>dt",
        "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        desc = "Toggle Breakpoint",
        nowait = false,
        remap = false,
    },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = false, remap = false },
    { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate", nowait = false, remap = false },
}

whichkey.add(keymap)

local keymap_v = {
    { "<leader>d", group = "debug", mode = "v", nowait = false, remap = false },
    {
        "<leader>de",
        "<cmd>lua require'dapui'.eval()<cr>",
        desc = "Evaluate",
        mode = "v",
        nowait = false,
        remap = false,
    },
}

whichkey.add(keymap_v)

--#endregion
