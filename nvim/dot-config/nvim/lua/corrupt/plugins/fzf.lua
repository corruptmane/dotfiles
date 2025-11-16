return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("fzf-lua").setup({
        winopts = {
          fullscreen = true,
          border = "none",
          backdrop = "0",
          preview = {
            default = "builtin",
            -- default = 'bat',
            horizontal = "right:50%",
            syntax_limit_b = 1024 * 100,
          },
        },
      })

      vim.cmd([[ FzfLua register_ui_select ]])

      vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua helptags<cr>", { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<cr>", { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "[S]earch [S]ymbols" })
      vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "[S]earch by [G]rep" })
      vim.keymap.set(
        "n",
        "<leader>sd",
        "<cmd>FzfLua lsp_workspace_diagnostics<cr>",
        { desc = "[S]earch [D]iagnostics" }
      )
      vim.keymap.set("n", "<leader>sp", "<cmd>FzfLua git_files<cr>", { desc = "[S]earch [P]roject git files" })
      vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua resume<cr>", { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<cr>", { desc = "[,] Find existing buffers" })
      vim.keymap.set(
        "n",
        "<leader>/",
        "<cmd>FzfLua lgrep_curbuf<cr>",
        { desc = "[/] Fuzzily search in current buffer" }
      )
    end,
  },
}
