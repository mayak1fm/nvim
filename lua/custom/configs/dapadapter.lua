local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-dap-18', -- adjust as needed, must be absolute path
  name = 'lldb'
}
