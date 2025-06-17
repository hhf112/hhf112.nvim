local plugins = {
  --AI
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = false,
          keymap = {
            next    = "<C-]>", -- Ctrl+]
            prev    = "<C-[>", -- Ctrl+[
            accept  = "<C-l>", -- Enter
            dismiss = "<C-e>", -- Ctrl+e (you can pick any free combo)
          },
        },
      })
    end,
  },
  --
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   lazy = false,
  --   config = function()
  --     require("supermaven-nvim").setup(
  --       {
  --         keymaps = {
  --           accept_suggestion = "<Tab>",
  --           clear_suggestion = "<C-]>",
  --           accept_word = "<C-j>",
  --         },
  --         color = {
  --           suggestion_color = "#ffffff",
  --           cterm = 244,
  --         },
  --         log_level = "info",                -- set to "off" to disable logging completely
  --         disable_inline_completion = false, -- disables inline completion for use with cmp
  --         disable_keymaps = false,           -- disables built in keymaps for more manual control
  --         condition = function()
  --           return false
  --         end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
  --       })
  --   end,
  -- },

  --LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
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
        "pyright",
        "gopls",
        "tailwindcss-language-server",
      }
    }
  },

  --FILE MANAGEMENT
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


  --THEMES & UI
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    lazy = false,
  },

  --DEV
  --
  --
  --

  --DEBUGGER UI
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
}

return plugins
