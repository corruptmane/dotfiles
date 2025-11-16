return {
  { -- LSP Configuration & Plugins
    "j-hui/fidget.nvim",
    config = function()
      require("corrupt.lsp").setup()

      require("fidget").setup({
        notification = {
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  -- used for completion, annotations and signatures of Neovim apis
  { "Bilal2453/luvit-meta", lazy = true },
}
