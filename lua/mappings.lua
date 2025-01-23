require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("v", "$", ";", { noremap = true, silent = true })
map("n", "$", ";", { noremap = true, silent = true })


map("v", "d$", "в;", { noremap = true, silent = true })
map("n", "d$", "в;", { noremap = true, silent = true })

map("n", "z=", "я=", { noremap = true, silent = true })
map("n", "zg", "яп", { noremap = true, silent = true })

map("n", "z", "я", { noremap = true, silent = true })
map("n", "z", "я", { noremap = true, silent = true })

local wk = require('which-key')
local diag = vim.diagnostic
local lsp = vim.lsp
wk.register(
  {
    l = {
      name = 'LSP',
      f = { function() lsp.buf.formatting() end, 'Format' },
      i = { function() lsp.buf.implementation() end, 'Implementation' },
      k = { function() lsp.buf.hover() end, 'Hover' },
      l = { function() diag.open_float() end, 'Show Line Diagnostics' },
      q = { function() diag.setloclist() end, 'Set Location List' },
      m = { function() lsp.buf.rename() end, 'Rename' },
      y = { function() lsp.buf.type_definition() end, 'Type Definition' },
      -- Telescope lsp maps
      D = { '<Cmd>Telescope lsp_document_diagnostics<Cr>', 'Diagnostics' },
      I = { '<Cmd>Telescope lsp_implementations<Cr>', 'Implementations' },
      d = { '<Cmd>Telescope lsp_definitions<Cr>', 'Definitions' },
      e = { '<Cmd>Telescope lsp_code_actions<Cr>', 'Code Actions' },
      r = { '<Cmd>Telescope lsp_references<Cr>', 'References' },
      s = { '<Cmd>Telescope lsp_document_symbols<Cr>', 'Symbols' },
      -- nvim-lsp-installer maps
      L = { '<Cmd>LspInstallInfo<Cr>', 'nvim-lsp-installer UI' },
    },
  },
  {
    prefix = '<Leader>'
  }
)

wk.register(
  {
    d = {
      name = 'DAP',
      b = { function() require('dap').toggle_breakpoint() end, "toggle_breakpoint" },
      B = { function() require('dap').set_breakpoint() end, "set_breakpoint" },
      l = { function() require('dap').run_last() end, "run_last" }
    }
  },
  {
    prefix = '<Leader>'
  }
)
