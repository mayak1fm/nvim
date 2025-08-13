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

--vim.api.nvim_create_autocmd('LspAttach', {
--  callback = function(ev)
--    local client = vim.lsp.get_client_by_id(ev.data.client_id)
--    if client:supports_method('textDocument/completion') then
--      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--    end
--  end,
--})
--

-- Отключает автофокус на LSP-окнах
--vim.api.nvim_create_autocmd('LspAttach', {
--  callback = function(args)
--    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf, desc = 'Показать документацию (без автофокуса)' })
--  end,
--})
--
--
---- Отключает авто-справку при вводе
--vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
--  vim.lsp.handlers.signature_help, {
--    focusable = false,  -- Запрещает фокусировку
--    silent = true       -- Отключает автоматическое открытие
--  }
--)


vim.schedule(function()
  require "mappings"
end)


