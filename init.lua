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
  pattern = { "markdown", "text" },
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

vim.lsp.enable { "clang", "pyright", "dart", "lua_ls", "protols" }

vim.filetype.add({
  filename = {
    ["DockerFileDev.custom"] = "dockerfile",
  },
})

-- OSC 52 clipboard (works over SSH / remote terminals)
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy "+",
    ["*"] = require("vim.ui.clipboard.osc52").copy "*",
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste "+",
    ["*"] = require("vim.ui.clipboard.osc52").paste "*",
  },
}

-- синхронизировать тему Alacritty при смене темы NvChad
vim.api.nvim_create_autocmd("User", {
  pattern = "NvThemeReload",
  callback = function()
    vim.schedule(function()
      local ok, err = pcall(require("configs.alacritty").sync)
      if ok then
        vim.notify("Alacritty theme synced", vim.log.levels.INFO)
      else
        vim.notify("Alacritty sync error: " .. tostring(err), vim.log.levels.ERROR)
      end
    end)
  end,
})
-- применить тему сразу при старте
vim.schedule(function()
  require("configs.alacritty").sync()
end)

vim.schedule(function()
  require "mappings"
end)
