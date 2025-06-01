---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "kanagawa",
  relativenumber = false,
  number = true,
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")
return M
