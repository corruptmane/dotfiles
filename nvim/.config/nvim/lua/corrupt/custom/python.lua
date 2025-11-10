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
vim.keymap.set("n", "<leader>cpl", function()
  insert_logging_setup()
  ---@diagnostic disable-next-line: missing-fields
end, { desc = "[C]ode [P]ython [L]ogger" })

