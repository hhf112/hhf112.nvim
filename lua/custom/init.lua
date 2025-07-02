--QUICK SETTINGS
vim.opt.relativenumber = false
vim.opt.swapfile = false

--remove windows carriage return on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd("silent! %s/\r//g")
    end,
})

-- COPILOT OVERRIDE
-- restore literal <Esc> behavior in Insert and Select modes
vim.keymap.set('i', '<Esc>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('s', '<Esc>', '<Esc>', { noremap = true, silent = true })



---CONVINIENCE
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.opt.termguicolors = true


--FLOATERMINAL KEYBINDS
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })
local toggleTerminal = require("custom.floaterminal")
vim.api.nvim_create_user_command("Floaterminal", toggleTerminal, {})
vim.keymap.set({ "t", "n" }, "<Space>tr", toggleTerminal, { noremap = true })


--OIL
vim.keymap.set("n", "<C-O>", function()
  vim.cmd("Oil")
  vim.api.nvim_feedkeys("_", "n", false) --directory of current buffer
end, {noremap = true})
