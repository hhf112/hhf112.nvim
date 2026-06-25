require "nvchad.autocmds"

-- faster for accidental mistype
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- remove windows carriager returns on copy-pasting
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd "silent! %s/\r//g"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { ".js", ".ts" },
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.js", "*.ts" },
  callback = function()

    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()

    -- You can call `try_lint` with a linter name or a list of names to always
    -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
  end,
})
