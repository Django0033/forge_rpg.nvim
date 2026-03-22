local M = {}

M.current_buf = nil
M.current_win = nil
M.current_data = nil
M.current_generator = nil

function M.open(content, data, generator)
  M.close()

  M.current_data = data
  M.current_generator = generator

  local lines = {}
  for line in content:gmatch("[^\n]+" ) do
    table.insert(lines, line)
  end

  local height = #lines
  local width = 43

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "readonly", true)

  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "single",
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_win_set_option(win, "cursorline", false)
  vim.api.nvim_win_set_option(win, "number", false)
  vim.api.nvim_win_set_option(win, "relativenumber", false)
  vim.api.nvim_win_set_option(win, "signcolumn", "no")
  vim.api.nvim_win_set_option(win, "foldcolumn", "0")
  vim.api.nvim_win_set_option(win, "spell", false)
  vim.api.nvim_win_set_option(win, "wrap", false)

  vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
    callback = function() M.close() end,
    noremap = true,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
    callback = function() M.close() end,
    noremap = true,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "r", "", {
    callback = function() M.reroll() end,
    noremap = true,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "i", "", {
    callback = function() M.insert() end,
    noremap = true,
    silent = true,
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
    callback = function() M.insert() end,
    noremap = true,
    silent = true,
  })

  vim.api.nvim_command("autocmd BufWipeout <buffer> lua require('forge-nvim.floatwin').on_close()")
  vim.api.nvim_command("au CursorMoved * ++once lua vim.defer_fn(function() vim.api.nvim_command('stopinsert') end, 0)")

  M.current_buf = buf
  M.current_win = win
end

function M.close()
  if M.current_win and vim.api.nvim_win_is_valid(M.current_win) then
    vim.api.nvim_win_close(M.current_win, true)
  end
  M.current_buf = nil
  M.current_win = nil
  M.current_data = nil
  M.current_generator = nil
end

function M.on_close()
  if M.current_win and vim.api.nvim_win_is_valid(M.current_win) then
    vim.api.nvim_win_close(M.current_win, true)
  end
  M.current_buf = nil
  M.current_win = nil
  M.current_data = nil
  M.current_generator = nil
end

function M.reroll()
  if M.current_generator and M.current_data then
    local new_data = M.current_generator.generate()
    local content = M.current_generator.to_float_content(new_data)
    M.open(content, new_data, M.current_generator)
  end
end

function M.insert()
  if not M.current_data then return end

  local target_buf = vim.api.nvim_get_current_buf()
  local md_content = M.current_generator.to_markdown(M.current_data)

  local lines = {}
  for line in md_content:gmatch("[^\n]+") do
    table.insert(lines, line)
  end

  vim.api.nvim_buf_set_option(target_buf, "modifiable", true)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1] - 1
  vim.api.nvim_buf_set_lines(target_buf, row, row, false, lines)
  vim.api.nvim_buf_set_option(target_buf, "modifiable", false)

  M.close()
end

return M
