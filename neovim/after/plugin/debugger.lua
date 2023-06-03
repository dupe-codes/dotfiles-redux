local dap = require('dap')
local dap_virtual_text_status = require("nvim-dap-virtual-text")
local dapui = require("dapui")

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
vim.fn.sign_define("DapBreakpoint", { text = icons.ui.TinyCircle, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.ui.CircleWithGap, texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = icons.ui.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.ui.Error, texthl = "Error", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- TODO: Setup adapters, starting with c++ lldb
--dap.adapters.codelldb = {
  --type = "server",
  --port = "${port}",
  --executable = {
    ---- CHANGE THIS to your path!
    --command = codelldb.codelldb_path,
    --args = { "--port", "${port}" },

    ---- On windows you may have to uncomment this:
    ---- detached = false,
  --}
--}

