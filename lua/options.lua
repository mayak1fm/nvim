require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both"
vim.opt.relativenumber = true
o.shell = "/usr/bin/zsh"
o.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.filetype.add({
  extension = {
    tpp = "cpp",
    cu = "cuda",
    cuh = "cuda",
  },
})
