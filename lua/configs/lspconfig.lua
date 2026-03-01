require("nvchad.configs.lspconfig").defaults()
local servers = {
  "html",
  "cssls",
  "clangd",
  "clang-format",
  "rust-analyzer",
  "codelldb",
  "ts_ls",
  "pyright",
  "gopls",
  "tailwindcss",
  "matlab",
}

vim.lsp.config("matlab", {
  filetypes = { "matlab" },
  cmd = { "node", "/home/hrsh/.local/share/nvim/mason/packages/matlab-language-server/out/index.js", "--stdio" },
  -- root_dir = function(fname)
  --   -- use .git folder if present, fallback to file's folder
  --   local git = vim.fs.find(".git", { path = fname, upward = true })[1]
  --   return git and vim.fs.dirname(git) or vim.fs.dirname(fname)
  -- end,
})

vim.lsp.config("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
})

vim.lsp.config("clangd", {
  cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
  },
  init_options = {
    fallbackFlags = { "-std=c++23" },
  },
})

vim.lsp.config("ts_ls", {
  init_options = {
    cmd = { "typescript-language-server", "--stdio" },
    preferences = {
      disableSuggestions = true,
    },
  },
})

vim.lsp.config("rust-analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable(servers)
