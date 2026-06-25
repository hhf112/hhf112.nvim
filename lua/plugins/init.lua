return {
  --dev {
  --
  --
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        cpp = { "clangtidy" },
        c = { "clangtidy" },
        python = { "flake8", "mypy" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        lua = { "luacheck" },
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    },
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },

  --}

  --AI {
  { -- this plugin is kind of useless because I only get to use mini models now and everything better is
    -- ppriced high
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-5-mini",
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.5,
      },
      -- See Configuration section for options
    },
  },

  {
    "supermaven-inc/supermaven-nvim",
    lazy = true,
    opts = {
      keymaps = {
        accept_suggestion = "<C-]>",
        clear_suggestion = "<C-[>",
        accept_word = "<C-l>",
      },
      colors = {
        suggestion_color = "#4c4c55",
        cterm = 244,
      },
      ignore_filetypes = { "cpp", "rust" },
      log_level = "off", -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
      condition = function()
        return true
      end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    },
  },
  --}

  -- files {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },
    config = function()
      return require "configs.telescope"
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
    config = function()
      -- This is your opts table
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            },

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@jype oil.SetupOpts
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,

        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,

        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  -- }

  --lsp
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "rust-analyzer",
        "codelldb",
        "typescript-language-server",
        "tsserver",
        "pyright",
        "gopls",
        "tailwindcss",
      },
    },
  },

  --debuggger
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
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
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  { "nvim-neotest/nvim-nio" },
}
