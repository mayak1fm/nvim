return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Обязательная зависимость
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim","lua", "vimdoc",
        "html", "css", "cpp",
        "python","yaml","markdown",
        "markdown_inline", "cmake","dockerfile"
      },
    },
  },
  {
    "sitiom/nvim-numbertoggle",
    event = "BufEnter",
    config = function()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = { "truncate" }, -- Обрезать начало пути, чтобы показать окончание
        },
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
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "second_brain",
          path = "~/Documents/second_brain",
        }
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = "30%", -- Ширина окна в процентах от ширины экрана
        },
        renderer = {
          indent_markers = {
            enable = true, -- Включить маркеры отступов
          },
        },
        actions = {
          change_dir = {
            enable = true,  -- Синхронизировать текущий каталог с корнем дерева
            global = false, -- Не изменять глобальный каталог
          },
          open_file = {
            resize_window = true, -- Автоматически изменять размер окна
            quit_on_open = false, -- Не закрывать дерево при открытии файла
          },
        },
        hijack_directories = {
            enable = false,       -- Блокируем смещение корня при открытии папки
        },
        update_focused_file = {
          enable = true,      -- Обновлять фокус на текущем файле
          update_root = false, -- Синхронизировать корень дерева с текущим каталогом
        },
      })
      -- Автоматически переходить к текущему файлу при открытии nvim-tree
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.filetype == "NvimTree" then
            require("nvim-tree.api").tree.find_file({ open = true, focus = true })
          end
        end,
      })
    end,
  },
  {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
    "ravitemer/mcphub.nvim" -- Добавленная зависимость
  },
  event = "VeryLazy",
  config = function()
    require("codecompanion").setup({
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = "sk-580b6d77bc94499781e7a3fc5cc20741",
            },
          })
        end,
      },
      prompt_library = {
        ["RussianChat"] = {
          strategy = "chat",
          description = "russian lang",
          prompts = {
            {
              role = "system",
              content = "You are an experienced developer with c++",
            },
            {
              role = "user",
              content = "Отвечай и рассуждай на русском языке ..."
            }
          },
        },
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "telescope",
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            auto_generate_title = true,
            title_generation_opts = {
              adapter = nil,
              model = nil,
              refresh_every_n_prompts = 0,
              max_refreshes = 3,
            },
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.expand("~/Documents/deepseek"),
            enable_logging = false,
            chat_filter = nil,
          }
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
          show_result_in_chat = true,  -- Show mcp tool results in chat
          make_vars = true,            -- Convert resources to #variables
          make_slash_commands = true,  -- Add prompts as /slash commands
          }
        }
      }
    })
  end
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
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,  -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
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
  },
  
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
}
