return {
  'stevearc/oil.nvim',
  dependencies = {
    {
      "echasnovski/mini.icons",
      opts = {}
    }
  },
  opts = {
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["gs"] = "actions.change_sort",
      ["g."] = "actions.toggle_hidden",
    },
  },
}
