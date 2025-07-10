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

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

vim.api.nvim_set_keymap('n', '<C-S-Left>', '<C-w><', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Right>', '<C-w>>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Up>', '<C-w>-', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Down>', '<C-w>+', {noremap = true})
vim.opt.mouse = 'a'

wk.add(
 {
    { "<Leader>l", group = "LSP" },
    { "<Leader>le", function() lsp.buf.code_action() end, desc = "Code Actions" },
    { "<Leader>ld", function() lsp.buf.declaration() end, desc = "Declaration" },
    { "<Leader>lD", function() lsp.buf.defenition() end, desc = "Defenition" },
    { "<Leader>lt", function() lsp.buf.type_defenition() end, desc = "Defenition" },
    { "<Leader>lr", function() lsp.buf.references() end, desc = "References" },
    { "<Leader>lf", function() lsp.buf.formatting() end, desc = "Format" },
    { "<Leader>li", function() lsp.buf.implementation() end, desc = "Implementation" },
    { "<Leader>lk", function() lsp.buf.hover() end, desc = "Hover" },
    { "<Leader>lm", function() lsp.buf.rename() end, desc = "Rename" },
    { "<Leader>ll", function() diag.open_float() end, desc = "Show Line Diagnostics" },
    { "<Leader>lq", function() diag.setloclist() end, desc = "Set Location List" },
  }
)


