return {

  {
    "christoomey/vim-tmux-navigator",
    config = function()
      -- Used to free <C-l> mapping inside netrw
      vim.keymap.set("n", "<C-e>", "<Plug>NetrwRefresh<CR>")
      -- Actual mappings
      vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>")
      vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>")
      vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>")
      vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>")
    end,
  },

}
