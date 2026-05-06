require "nvchad.mappings"

local map = vim.keymap.set
local wk = require "which-key"
local diag = vim.diagnostic
local lsp = vim.lsp

-- ============================================================
-- General
-- ============================================================
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ============================================================
-- Clipboard (OSC 52 / system)
-- ============================================================
map("v", "<C-c>", '"+y',    { noremap = true, desc = "Copy to clipboard" })
map("i", "<C-v>", "<C-r>+", { noremap = true, desc = "Paste from clipboard" })

-- ============================================================
-- Window resize
-- ============================================================
map("n", "<C-S-Left>",  "<C-w><", { noremap = true, desc = "Resize window left" })
map("n", "<C-S-Right>", "<C-w>>", { noremap = true, desc = "Resize window right" })
map("n", "<C-S-Up>",    "<C-w>-", { noremap = true, desc = "Resize window up" })
map("n", "<C-S-Down>",  "<C-w>+", { noremap = true, desc = "Resize window down" })

-- ============================================================
-- Harpoon (быстрые C-1..4 вне групп, add через which-key)
-- ============================================================
local harpoon = require "harpoon"
map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
map("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

-- ============================================================
-- which-key groups
-- ============================================================
wk.add {

  -- Harpoon
  { "<leader>p",  group = "Harpoon" },
  { "<leader>pa", function() harpoon:list():add() end,                        desc = "Add file" },
  { "<leader>pm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Menu" },
  { "<leader>p1", function() harpoon:list():select(1) end,                    desc = "File 1" },
  { "<leader>p2", function() harpoon:list():select(2) end,                    desc = "File 2" },
  { "<leader>p3", function() harpoon:list():select(3) end,                    desc = "File 3" },
  { "<leader>p4", function() harpoon:list():select(4) end,                    desc = "File 4" },

  -- Search / Spectre
  { "<leader>s",  group = "Search" },
  { "<leader>sc", "z=",                                                                          desc = "Spell suggestions" },
  { "<leader>sS", '<cmd>lua require("spectre").toggle()<CR>',                                    desc = "Spectre toggle" },
  { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',             desc = "Search current word" },
  { "<leader>sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',        desc = "Search in file" },

  -- Git
  { "<leader>g",  group = "Git" },
  { "<leader>gg", "<cmd>LazyGit<cr>",                  desc = "LazyGit" },
  { "<leader>gd", "<cmd>DiffviewOpen<cr>",             desc = "Diffview open" },
  { "<leader>gD", "<cmd>DiffviewClose<cr>",            desc = "Diffview close" },
  { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",    desc = "File history" },
  { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",      desc = "Branch history" },

  -- DAP
  { "<leader>d",  group = "DAP" },
  { "<leader>dc", '<cmd>lua require("dap").continue()<cr>',                   desc = "Continue" },
  { "<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<cr>',          desc = "Toggle breakpoint" },
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input "Condition: ") end, desc = "Conditional breakpoint" },
  { "<leader>do", '<cmd>lua require("dap").step_over()<cr>',                  desc = "Step over" },
  { "<leader>di", '<cmd>lua require("dap").step_into()<cr>',                  desc = "Step into" },
  { "<leader>dO", '<cmd>lua require("dap").step_out()<cr>',                   desc = "Step out" },
  { "<leader>du", '<cmd>lua require("dapui").toggle()<cr>',                   desc = "Toggle UI" },
  { "<leader>dr", '<cmd>lua require("dap").repl.open()<cr>',                  desc = "REPL" },
  { "<leader>dl", '<cmd>lua require("dap").run_last()<cr>',                   desc = "Run last" },
  { "<leader>dx", '<cmd>lua require("dap").terminate()<cr>',                  desc = "Terminate" },

  -- Clangd (C++)
  { "<leader>c",  group = "Clangd" },
  { "<leader>cs", "<cmd>ClangdSwitchSourceHeader<cr>",                        desc = "Switch header/source" },
  { "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>",                             desc = "Type hierarchy" },
  { "<leader>ca", "<cmd>ClangdAST<cr>",                                       desc = "AST viewer" },
  { "<leader>cm", "<cmd>ClangdMemoryUsage<cr>",                               desc = "Memory usage" },
  { "<leader>ci", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle inlay hints" },

  -- LSP
  { "<leader>l",  group = "LSP" },
  { "<leader>le", function() lsp.buf.code_action() end,     desc = "Code actions" },
  { "<leader>ld", function() lsp.buf.declaration() end,     desc = "Declaration" },
  { "<leader>lD", function() lsp.buf.definition() end,      desc = "Definition" },
  { "<leader>lt", function() lsp.buf.type_definition() end, desc = "Type definition" },
  { "<leader>lr", function() lsp.buf.references() end,      desc = "References" },
  { "<leader>lf", function() lsp.buf.format() end,          desc = "Format" },
  { "<leader>li", function() lsp.buf.implementation() end,  desc = "Implementation" },
  { "<leader>lk", function() lsp.buf.hover() end,           desc = "Hover" },
  { "<leader>lm", function() lsp.buf.rename() end,          desc = "Rename" },
  { "<leader>ll", function() diag.open_float() end,         desc = "Line diagnostics" },
  { "<leader>lq", function() diag.setloclist() end,         desc = "Location list" },
}

-- F-клавиши DAP (дублируют группу, для удобства в процессе отладки)
map("n", "<F5>",  '<cmd>lua require("dap").continue()<cr>',   { desc = "DAP continue" })
map("n", "<F10>", '<cmd>lua require("dap").step_over()<cr>',  { desc = "DAP step over" })
map("n", "<F11>", '<cmd>lua require("dap").step_into()<cr>',  { desc = "DAP step into" })
map("n", "<F12>", '<cmd>lua require("dap").step_out()<cr>',   { desc = "DAP step out" })

-- Spectre visual mode
map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search selection" })
