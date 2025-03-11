return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "cpp",
        "python", "markdown",
        "markdown_inline","cmake"
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = { "truncate" },  -- Обрезать начало пути, чтобы показать окончание
          -- Или можно использовать:
          -- path_display = { "shorten" },  -- Сократить путь, показывая только важные части
          -- path_display = { "tail" },     -- Показывать только окончание пути (имя файла)
        },
--        pickers = {
--          find_files = {
--            theme = "dropdown",  -- Использовать выпадающий список
--          },
--          live_grep = {
--            theme = "dropdown",  -- Использовать выпадающий список
--          },
--        },
      })
    end,
  },
  {
    'nativerv/cyrillic.nvim',
    event = { 'VeryLazy' },
    config = function()
      require('cyrillic').setup({
        no_cyrillic_abbrev = false, -- default
      })
    end,
  },
  {
    "nvim-neotest/nvim-nio"
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require "configs.dapadapter"
      require "configs.dapconfig"
    end
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },

  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", 'echasnovski/mini.nvim' },
    config = function()
      require("render-markdown").setup({})
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "second_brain",
          path = "~/second_brain",
        }
      },
      --      ui = { enable = false },
      -- see below for full list of options 👇
    },
  },
  {
   "nvim-tree/nvim-tree.lua",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
     require("nvim-tree").setup({
      view = {
        width = "30%",  -- Ширина окна в процентах от ширины экрана
        -- Или фиксированная ширина в пикселях:
        -- width = 300,  -- Ширина окна в пикселях
      },
      renderer = {
        indent_markers = {
          enable = true,  -- Включить маркеры отступов
        },
      },
     -- filters = {
     --   dotfiles = true,  -- Показывать ли скрытые файлы (начинающиеся с точки)
     -- },
      actions = {
        change_dir = {
          enable = true,  -- Синхронизировать текущий каталог с корнем дерева
          global = false, -- Не изменять глобальный каталог
        },
        open_file = {
          resize_window = true,  -- Автоматически изменять размер окна
          quit_on_open = false,  -- Не закрывать дерево при открытии файла
        },
      },
      update_focused_file = {
        enable = true,  -- Обновлять фокус на текущем файле
        update_root = true,  -- Синхронизировать корень дерева с текущим каталогом
      },
    })
    -- Автоматически переходить к текущему файлу при открытии nvim-tree
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if vim.bo.filetype == "NvimTree" then
          require("nvim-tree.api").tree.find_file({ open = true, focus = true })
        end
      end,
    })   end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,     -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,         -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,        -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false,     -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,     -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",       -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,      -- Use default
        max_file_length = 40000,     -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  }
}
