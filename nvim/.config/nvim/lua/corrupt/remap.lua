local map = function(mode, keys, func, opts)
  vim.keymap.set(mode, keys, func, opts)
end

-- Disable highlighting on <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line down, automatically indent' })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line up, automatically indent' })

map('n', '<C-d>', '<C-d>zz', { desc = 'Navigate down and center screen automatically' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Navigate up and center screen automatically' })

map('n', 'n', 'nzzzv', { desc = 'Navigate to next pattern, center screen automatically' })
map('n', 'N', 'Nzzzv', { desc = 'Navigate to previous pattern, center screen automatically' })

map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank (copy) to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank (copy) to system clipboard' })

map({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to null registry' })

map('n', '<leader>|', '<cmd>vsp<CR>', { desc = 'Open vertical split' })
map('n', '<leader>-', '<cmd>sp<CR>', { desc = 'Open horizontal split' })

map('n', '-', ':Oil<CR>')

map('n', '<leader>tc', vim.cmd.tabnew, { desc = 'Create new tab' })
map('n', '<leader>tq', vim.cmd.tabc, { desc = 'Quit current tab' })
map('n', '<leader>tn', vim.cmd.tabn, { desc = 'Next tab' })
map('n', '<leader>tN', vim.cmd.tabN, { desc = 'Previous tab' })

--
--
-- Function to find the last import statement line number
local function find_last_import()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local last_import_line = 0

  for i, line in ipairs(lines) do
    if line:match("^import ") or line:match("^from ") then
      last_import_line = i
    end
  end

  return last_import_line
end

local action_format_code = function()
  vim.lsp.buf.format()
  vim.lsp.buf.code_action({
    ---@diagnostic disable-next-line: missing-fields
    context = {
      only = { "source.organizeImports" }
    },
    filter = function(action)
      return action.title == "Ruff: Organize imports"
    end,
    apply = true,
  })
end

-- Function to insert the logging setup after the last import
local function insert_logging_setup()
  local pos = vim.api.nvim_win_get_cursor(0)
  local last_import = find_last_import()

  -- Store the current cursor position
  local cursor_line = pos[1]
  local cursor_col = pos[2]

  -- Insert the import statement after the last import
  vim.api.nvim_buf_set_lines(0, last_import, last_import, false,
    { "import logging", "", "log = logging.getLogger(__name__)" })

  -- Restore cursor position, adjusting for the added lines
  if cursor_line > last_import then
    cursor_line = cursor_line + 3 -- Adding 3 lines: import, empty line, and log definition
  end
  vim.api.nvim_win_set_cursor(0, { cursor_line, cursor_col })

  -- Format the code
  action_format_code()
end

-- Optional: Add a keymap
map("n", "<leader>ll", function()
  insert_logging_setup()
  ---@diagnostic disable-next-line: missing-fields
end, { desc = "Insert Python logging setup" })
