local dap = require "dap"

-- lldb-dap: перебираем доступные версии
local function find_lldb_dap()
  local candidates = {
    "/usr/bin/lldb-dap-19",
    "/usr/bin/lldb-dap-18",
    "/usr/bin/lldb-dap-17",
    "/usr/bin/lldb-dap",
  }
  for _, path in ipairs(candidates) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
end

-- codelldb от mason (портативный вариант для Docker)
local mason_codelldb = vim.fn.stdpath "data" .. "/mason/bin/codelldb"

if vim.fn.executable(mason_codelldb) == 1 then
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = mason_codelldb,
      args = { "--port", "${port}" },
    },
  }
end

local lldb_dap = find_lldb_dap()
if lldb_dap then
  dap.adapters.lldb = {
    type = "executable",
    command = lldb_dap,
    name = "lldb",
  }
end
