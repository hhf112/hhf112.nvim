local plugins = {
  --------------------------------------~!DEV---
  --UTILITY
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    lazy = false,
  },

  --AI
  {
    "supermaven-inc/supermaven-nvim",
    lazy = true,
    config = function()
      require("supermaven-nvim").setup(
        {
          keymaps = {
            accept_suggestion = "<C-]>",
            clear_suggestion = "<C-]]>",
            accept_word = "<C-l>",
          },
          color = {
            suggestion_color = "#4c4c55",
            cterm = 244,
          },
          log_level = "info",                -- set to "off" to disable logging completely
          disable_inline_completion = false, -- disables inline completion for use with cmp
          disable_keymaps = false,           -- disables built in keymaps for more manual control
          condition = function()
            return true
          end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
        })
    end,
  },

  --LSP, I use cmp with under nvchad
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "rust-analyzer",
        "codelldb",
        "typescript-language-server",
        "pyright",
        "gopls",
        "tailwindcss-language-server",
      }
    }
  },

  --DEBUGGER
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "willaimboman/mason.nvim",
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
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  { "nvim-neotest/nvim-nio" },

  -----------------------------------------~!EDITOR-----------

  --THEMES
  {
    "rebelot/kanagawa.nvim", ----current
    priority = 1000,
    lazy = false,
    config = function()
      require("kanagawa").setup({
        overrides = function(colors)
          return {
            --colorless numberline
            LineNr       = { fg = colors.palette.fujiGray, bg = "NONE" },
            CursorLineNr = { fg = colors.palette.springBlue, bg = "NONE" },
            SignColumn   = { bg = "NONE" },
            FoldColumn   = { bg = "NONE" },
          }
        end,
      })
      vim.cmd("colorscheme kanagawa-wave")
      --
      --Default Telescope Override
      vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
      vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "Normal" })
      --Colorless cursorline
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
    end,
  },


  ---ADDITIONAL UI-------------------
  {
    "xiyaowong/transparent.nvim",
    lazy = true,
  },

  --FILE MANAGEMENT
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

    },
    config = function()
      return require "custom.configs.telescope"
    end,
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@jype oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,

    config = function()
      require "custom.configs.oil"
    end
  },
}

return plugins
