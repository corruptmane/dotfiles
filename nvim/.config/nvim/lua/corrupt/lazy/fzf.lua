return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("fzf-lua").setup {
        winopts = {
          fullscreen = true,
          border = 'none',
          backdrop = '0',
          preview = {
            default = 'builtin',
            -- default = 'bat',
            horizontal = "right:50%",
            syntax_limit_b = 1024 * 100,
          },
        },
      }

      vim.cmd [[ FzfLua register_ui_select ]]

      vim.keymap.set('n', '<leader>sh', "<cmd>FzfLua helptags<cr>", { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', "<cmd>FzfLua keymaps<cr>", { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', "<cmd>FzfLua files<cr>", { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', "<cmd>FzfLua lsp_document_symbols<cr>", { desc = '[S]earch [S]ymbols' })
      vim.keymap.set('n', '<leader>sw', "<cmd>FzfLua grep_cword<cr>", { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', "<cmd>FzfLua live_grep<cr>", { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', "<cmd>FzfLua lsp_workspace_diagnostics<cr>", { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sp', "<cmd>FzfLua git_files<cr>", { desc = '[S]earch [P]roject git files' })
      vim.keymap.set('n', '<leader>sr', "<cmd>FzfLua resume<cr>", { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader><leader>', "<cmd>FzfLua buffers<cr>", { desc = '[,] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', "<cmd>FzfLua lgrep_curbuf<cr>", { desc = '[/] Fuzzily search in current buffer' })
    end
  },
}
-- return {
--
--   {
--     'nvim-telescope/telescope.nvim',
--     event = 'VimEnter',
--     branch = '0.1.x',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'nvim-telescope/telescope-ui-select.nvim',
--       { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
--     },
--     config = function()
--       require('telescope').setup {
--         extensions = {
--           ['ui-select'] = {
--             require('telescope.themes').get_dropdown(),
--           },
--         },
--       }
--
--       -- Enable Telescope extensions if they are installed
--       pcall(require('telescope').load_extension, 'fzf')
--       pcall(require('telescope').load_extension, 'aerial')
--       pcall(require('telescope').load_extension, 'ui-select')
--
--       local call_with_git_as_root = function(f)
--         return function()
--           f { cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }
--         end
--       end
--
--       local builtin = require 'telescope.builtin'
--       vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
--       vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
--       vim.keymap.set('n', '<leader>sf', call_with_git_as_root(builtin.find_files), { desc = '[S]earch [F]iles' })
--       -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
--       vim.keymap.set('n', '<leader>ss', function()
--         require("telescope").extensions.aerial.aerial()
--       end, { desc = '[S]earch [S]ymbols' })
--       vim.keymap.set('n', '<leader>sw', call_with_git_as_root(builtin.grep_string), { desc = '[S]earch current [W]ord' })
--       vim.keymap.set('n', '<leader>sg', call_with_git_as_root(builtin.live_grep), { desc = '[S]earch by [G]rep' })
--       vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
--       vim.keymap.set('n', '<leader>sp', builtin.git_files, { desc = '[S]earch [P]roject git files' })
--       vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
--       vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[,] Find existing buffers' })
--
--       vim.keymap.set('n', '<leader>/', function()
--           builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--             winblend = 20,
--             previewer = false,
--           })
--         end,
--         { desc = '[/] Fuzzily search in current buffer' }
--       )
--
--       vim.keymap.set('n', '<leader>s/', function()
--         builtin.live_grep {
--           grep_open_files = true,
--           prompt_title = 'Live Grep in Open Files',
--         }
--       end, { desc = '[S]earch [/] in Open Files' })
--
--       -- Shortcut for searching Neovim configuration files
--       vim.keymap.set('n', '<leader>sn', function()
--         builtin.find_files { cwd = vim.fn.stdpath 'config' }
--       end, { desc = '[S]earch [N]eovim files' })
--     end,
--   },
--
-- }
