---@type ChadrcConfig
local M = {}

-- comment to prevent core implementation overrides with plugins
-- M.ui = {
--   theme = "kanagawa-wave",
-- }
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")


vim.schedule(function()
vim.cmd("colorscheme kanagawa-wave")
end)

vim.schedule(function()
vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "Normal" })
--Colorless cursorline
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
end)

return M
