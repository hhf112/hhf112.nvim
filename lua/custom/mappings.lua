--To0 lazy to add all bindings here but will
local M = {}

--LEADER = <space>
M.dap = {
  plugin = true,
  n = {
    --NVIMDAP
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },


  }
}

return M
