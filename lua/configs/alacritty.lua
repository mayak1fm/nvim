local M = {}

local out      = vim.fn.expand "~/.config/alacritty/theme-current.toml"
local main_cfg = vim.fn.expand "~/.config/alacritty/alacritty.toml"

function M.sync()
  local ok, c = pcall(dofile, vim.g.base46_cache .. "colors")
  if not ok or not c then
    vim.notify("alacritty sync: cannot read base46 colors", vim.log.levels.WARN)
    return
  end

  local lines = {
    "[colors.primary]",
    ('background = "%s"'):format(c.black),
    ('foreground = "%s"'):format(c.white),
    ('dim_foreground = "%s"'):format(c.grey_fg),
    "",
    "[colors.cursor]",
    ('text = "%s"'):format(c.black),
    ('cursor = "%s"'):format(c.green),
    "",
    "[colors.vi_mode_cursor]",
    ('text = "%s"'):format(c.black),
    ('cursor = "%s"'):format(c.blue),
    "",
    "[colors.selection]",
    ('text = "%s"'):format(c.black),
    ('background = "%s"'):format(c.one_bg3),
    "",
    "[colors.search.matches]",
    ('foreground = "%s"'):format(c.black),
    ('background = "%s"'):format(c.yellow),
    "",
    "[colors.search.focused_match]",
    ('foreground = "%s"'):format(c.black),
    ('background = "%s"'):format(c.green),
    "",
    "[colors.normal]",
    ('black   = "%s"'):format(c.one_bg3),
    ('red     = "%s"'):format(c.red),
    ('green   = "%s"'):format(c.green),
    ('yellow  = "%s"'):format(c.yellow),
    ('blue    = "%s"'):format(c.blue),
    ('magenta = "%s"'):format(c.dark_purple),
    ('cyan    = "%s"'):format(c.cyan),
    ('white   = "%s"'):format(c.white),
    "",
    "[colors.bright]",
    ('black   = "%s"'):format(c.grey_fg),
    ('red     = "%s"'):format(c.baby_pink),
    ('green   = "%s"'):format(c.vibrant_green),
    ('yellow  = "%s"'):format(c.sun),
    ('blue    = "%s"'):format(c.nord_blue),
    ('magenta = "%s"'):format(c.purple),
    ('cyan    = "%s"'):format(c.teal),
    ('white   = "%s"'):format(c.white),
    "",
    "[colors]",
    "draw_bold_text_with_bright_colors = true",
  }

  local f = io.open(out, "w")
  if not f then
    vim.notify("alacritty sync: cannot write " .. out, vim.log.levels.WARN)
    return
  end
  f:write(table.concat(lines, "\n") .. "\n")
  f:close()

  -- touch основного конфига чтобы Alacritty подхватил изменение импортируемого файла
  vim.uv.fs_utime(main_cfg, os.time(), os.time())
end

return M
