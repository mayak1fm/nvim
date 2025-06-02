require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


map("v", "d$", "в;", { noremap = true, silent = true })
map("n", "d$", "в;", { noremap = true, silent = true })

map("n", "z=", "я=", { noremap = true, silent = true })
map("n", "zg", "яп", { noremap = true, silent = true })

map("n", "z", "я", { noremap = true, silent = true })

local wk = require('which-key')
local diag = vim.diagnostic
local lsp = vim.lsp

wk.add(
 {
    { "<Leader>l", group = "LSP" },
    { "<Leader>lD", "<Cmd>Telescope lsp_document_diagnostics<Cr>", desc = "Diagnostics" },
    { "<Leader>lI", "<Cmd>Telescope lsp_implementations<Cr>", desc = "Implementations" },
    { "<Leader>lL", "<Cmd>LspInstallInfo<Cr>", desc = "nvim-lsp-installer UI" },
    { "<Leader>ld", "<Cmd>Telescope lsp_definitions<Cr>", desc = "Definitions" },
    { "<Leader>le", "<Cmd>Telescope lsp_code_actions<Cr>", desc = "Code Actions" },
    { "<Leader>lf", function() lsp.buf.formatting() end, desc = "Format" },
    { "<Leader>li", function() lsp.buf.implementation() end, desc = "Implementation" },
    { "<Leader>lk", function() lsp.buf.hover() end, desc = "Hover" },
    { "<Leader>ll", function() diag.open_float() end, desc = "Show Line Diagnostics" },
    { "<Leader>lm", function() lsp.buf.rename() end, desc = "Rename" },
    { "<Leader>lq", function() diag.setloclist() end, desc = "Set Location List" },
    { "<Leader>lr", "<Cmd>Telescope lsp_references<Cr>", desc = "References" },
    { "<Leader>ls", "<Cmd>Telescope lsp_document_symbols<Cr>", desc = "Symbols" },
    { "<Leader>ly", function() lsp.buf.type_definition() end, desc = "Type Definition" },
  }  
)


