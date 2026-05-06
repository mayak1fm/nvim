local dap = require "dap"

local function pick_executable()
  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

local lldb_configs = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = pick_executable,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
  {
    name = "Attach",
    type = "lldb",
    request = "attach",
    program = pick_executable,
    pid = function()
      local name = vim.fn.input "Executable name (filter): "
      return require("dap.utils").pick_process { filter = name }
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    -- требует: echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    runInTerminal = true,
  },
}

local codelldb_configs = {
  {
    name = "Launch (codelldb)",
    type = "codelldb",
    request = "launch",
    program = pick_executable,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

-- применяем то что доступно
local function make_configs()
  local cfgs = {}
  if dap.adapters.codelldb then
    vim.list_extend(cfgs, codelldb_configs)
  end
  if dap.adapters.lldb then
    vim.list_extend(cfgs, lldb_configs)
  end
  return cfgs
end

local configs = make_configs()
dap.configurations.cpp  = configs
dap.configurations.c    = configs
dap.configurations.cuda = configs
