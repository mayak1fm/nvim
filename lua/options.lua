require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = 'both' -- to enable cursorline!
vim.opt.relativenumber = true -- Показывать относительные номера
o.shell = "/usr/bin/zsh" -- терминал zsh
o.clipboard = "unnamedplus" -- чтоб копировать по кайфу

vim.filetype.add({
  extension = {
    tpp = "cpp", -- Распознавать .tpp файлы как C++
  },
})
