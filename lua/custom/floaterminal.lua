--simple tutorial 

local mult = 0.7;
--store the state if opened once
local state = {
  floating = {
    buf = -1,
    win = -1,

  }
}

--the thing
local function hrszo_floating_window(opts)
  --dimensions and options
  opts = opts or {}
  local width = opts.widht or math.floor(vim.o.columns * mult)
  local height = opts.height or math.floor(vim.o.lines * mult)

  --anchored at center
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  --no file, scratch buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf or -1) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end


  --define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  --create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)


  return { buf = buf, win = win }
end

--self explanatory
local toggleTerminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = hrszo_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    --becomes invalid when goes hidden?
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.keymap.set({ "t", "n" }, "<Space>tr", toggleTerminal, { noremap = true })

return toggleTerminal
