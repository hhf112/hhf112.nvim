--NVCHAD BASE
local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities
local util = require "lspconfig/util"

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    -- client.server_capabilities.completionProvider  = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  init_options = {
    fallbackFlags = { '-std=c++23' },
  },
}

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust_analyzer'] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

lspconfig.ts_ls.setup {
  on_attach    = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }

}

lspconfig.pyright.setup {
  on_attach    = on_attach,
  capabilities = capabilities,
  filetypes    = { "python" },

}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
}

lspconfig.tailwindcss.setup {
  default_config = {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
      -- html
      'aspnetcorerazor',
      'astro',
      'astro-markdown',
      'blade',
      'clojure',
      'django-html',
      'htmldjango',
      'edge',
      'eelixir', -- vim ft
      'elixir',
      'ejs',
      'erb',
      'eruby', -- vim ft
      'gohtml',
      'gohtmltmpl',
      'haml',
      'handlebars',
      'hbs',
      'html',
      'htmlangular',
      'html-eex',
      'heex',
      'jade',
      'leaf',
      'liquid',
      'markdown',
      'mdx',
      'mustache',
      'njk',
      'nunjucks',
      'php',
      'razor',
      'slim',
      'twig',
      -- css
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'stylus',
      'sugarss',
      -- js
      'javascript',
      'javascriptreact',
      'reason',
      'rescript',
      'typescript',
      'typescriptreact',
      -- mixed
      'vue',
      'svelte',
      'templ',
    },
    settings = {
      tailwindCSS = {
        validate = true,
        lint = {
          cssConflict = 'warning',
          invalidApply = 'error',
          invalidScreen = 'error',
          invalidVariant = 'error',
          invalidConfigPath = 'error',
          invalidTailwindDirective = 'error',
          recommendedVariantOrder = 'warning',
        },
        classAttributes = {
          'class',
          'className',
          'class:list',
          'classList',
          'ngClass',
        },
        includeLanguages = {
          eelixir = 'html-eex',
          eruby = 'erb',
          templ = 'html',
          htmlangular = 'html',
        },
      },
    },
    on_new_config = function(new_config)
      if not new_config.settings then
        new_config.settings = {}
      end
      if not new_config.settings.editor then
        new_config.settings.editor = {}
      end
      if not new_config.settings.editor.tabSize then
        -- set tab size for hover
        new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
      end
    end,
    root_dir = function(fname)
      local root_file = {
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'tailwind.config.ts',
        'postcss.config.js',
        'postcss.config.cjs',
        'postcss.config.mjs',
        'postcss.config.ts',
      }
      root_file = util.insert_package_json(root_file, 'tailwindcss', fname)
      return util.root_pattern(unpack(root_file))(fname)
    end,
  },
  docs = {
    description = [[
https://github.com/tailwindlabs/tailwindcss-intellisense

Tailwind CSS Language Server can be installed via npm:
```sh
npm install -g @tailwindcss/language-server
```
]],
  },
}
