vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)


vim.api.nvim_create_autocmd("FileType", {
  pattern = {"markdown", "text"},
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en,ru"
  end,
})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.lsp.enable({'clang','pyright'})

vim.filetype.add({
  filename = {
    ["DockerFileDev.custom"] = "dockerfile",
  },
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'y' then
      local data = vim.fn.getreg('"')
      local encoded = vim.fn.system('base64 -w0 | tr -d "\\n"', data)
      vim.fn.chansend(vim.v.stderr, '\027]52;c;' .. encoded .. '\027\\')
    end
  end,
})


vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
-- Автоматически использовать системный буфер обмена для всех операций
vim.opt.clipboard = 'unnamedplus'

-- Клавиши для копирования/вставки с системным буфером
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true })
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true })
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true })

vim.schedule(function()
  require "mappings"
end)


