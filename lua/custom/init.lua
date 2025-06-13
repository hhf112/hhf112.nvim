vim.opt.relativenumber = true
vim.opt.swapfile = false


vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd("silent! %s/\r//g")
    end,
})

vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.opt.termguicolors = true




--FLOATERMINAL KEYBINDS
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })
local toggleTerminal = require("custom.floaterminal")
vim.api.nvim_create_user_command("Floaterminal", toggleTerminal, {})
vim.keymap.set({ "t", "n" }, "<Space>tr", toggleTerminal, { noremap = true })
vim.keymap.set("n", "<C-G>", function()
  vim.cmd("Oil")
  vim.api.nvim_feedkeys("_", "n", false)
end, {noremap = true})
