---@type ChadrcConfig
local M = {}

-- comment to prevent core implementation overrides with plugins
-- M.ui = {
--   theme = "kanagawa",
-- }
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")
return M
