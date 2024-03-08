local dap = require('dap')
local dap_virtual_text_status = require("nvim-dap-virtual-text")
local dapui = require("dapui")

dap_virtual_text_status.setup {
    commented = true,
}

dapui.setup({
  layouts = {
    {
      elements = {
        "scopes",
        "stacks",
        "watches",
      },
      size = 0.2,
      position = "left",
    },
    {
      elements = {
        "console",
      },
      size = 0.2,
      position = "bottom",
    },
  },
  controls = {
    enabled = false,
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
})

local icons = {
    ui = {
        TinyCircle = "●",
        CircleWithGap = "○",
        ChevronRight = "▶",
        LogPoint = "◉"
    },
    Error = "",
}

vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
vim.fn.sign_define("DapBreakpoint", {
    text = icons.ui.TinyCircle,
    texthl = "DapBreakpoint",
    linehl = "",
    numhl = ""
})
vim.fn.sign_define("DapBreakpointCondition", {
    text = icons.ui.CircleWithGap,
    texthl = "DapBreakpointCondition",
    linehl = "",
    numhl = ""
})
vim.fn.sign_define("DapLogPoint", {
    text = icons.ui.LogPoint,
    texthl = "DapLogPoint",
    linehl = "",
    numhl = ""
})
vim.fn.sign_define("DapStopped", {
    text = icons.ui.ChevronRight,
    texthl = "Error",
    linehl = "DapStoppedLinehl",
    numhl = ""
})
vim.fn.sign_define("DapBreakpointRejected", {
    text = icons.ui.Error,
    texthl = "Error",
    linehl = "",
    numhl = ""
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
    program = vim.fn.getcwd() .. "/" .. find_django_manage_file(),
    args = { "runserver", "0.0.0.0:8000", "--noreload" },
})

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
    console = "integratedTerminal"
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
    stopOnEntry = false
}
dap.configurations.c = { c_dap_config }

--#endregion

--#region
-- Setup debugging keymaps

local whichkey = require "which-key"

whichkey.setup({
    ignore_missing = true -- only have whichkey enabled for debug keymaps
})

local keymap = {
    d = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },
  }

whichkey.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

local keymap_v = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}

whichkey.register(keymap_v, {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})

--#endregion

