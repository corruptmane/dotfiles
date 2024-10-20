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

map({'n', 'v'}, '<leader>y', [["+y]], { desc = 'Yank (copy) to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank (copy) to system clipboard' })

map({'n', 'v'}, '<leader>d', [["_d]], { desc = 'Delete to null registry' })

map('n', '<leader>|', '<cmd>vsp<CR>', { desc = 'Open vertical split' })
map('n', '<leader>-', '<cmd>sp<CR>', { desc = 'Open horizontal split' })

map('n', '-', ':Oil<CR>')

map('n', '<leader>tc', vim.cmd.tabnew, { desc = 'Create new tab' })
map('n', '<leader>tq', vim.cmd.tabc, { desc = 'Quit current tab' })
map('n', '<leader>tn', vim.cmd.tabn, { desc = 'Next tab' })
map('n', '<leader>tN', vim.cmd.tabN, { desc = 'Previous tab' })
