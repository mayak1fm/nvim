local M = {}

local out      = vim.fn.expand "~/.config/alacritty/theme-current.toml"
local main_cfg = vim.fn.expand "~/.config/alacritty/alacritty.toml"

local function sync_alacritty(c)
  local lines = {
    "[colors.primary]",
    ('background = "%s"'):format(c.black),
    ('foreground = "%s"'):format(c.white),
    ('dim_foreground = "%s"'):format(c.grey_fg),
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

  -- удаляем симлинк если есть, создаём обычный файл
  os.remove(out)
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

local function sync_tmux(c)
  if vim.fn.executable "tmux" == 0 then return end
  if not vim.env.TMUX then return end

  local cmds = {
    ('tmux set -g status-style "fg=%s,bg=%s"'):format(c.white, c.statusline_bg),
    ('tmux set -g status-left "#[fg=%s]%%H:%%M #[fg=%s]• "'):format(c.green, c.white),
    ('tmux set -g window-status-current-format "#[fg=%s,bg=%s] #I:#W "'):format(c.black, c.green),
    ('tmux set -g window-status-format "#[fg=%s,bg=%s] #I:#W "'):format(c.green, c.one_bg2),
    ('tmux set -g pane-border-style "fg=%s"'):format(c.one_bg3),
    ('tmux set -g pane-active-border-style "fg=%s"'):format(c.green),
    ('tmux set -g message-style "fg=%s,bg=%s"'):format(c.black, c.yellow),
  }

  for _, cmd in ipairs(cmds) do
    vim.fn.system(cmd)
  end
end

function M.sync()
  local ok, c = pcall(dofile, vim.g.base46_cache .. "colors")
  if not ok or not c then
    vim.notify("theme sync: cannot read base46 colors", vim.log.levels.WARN)
    return
  end

  sync_alacritty(c)
  sync_tmux(c)
end

return M
