return {
  "supermaven-inc/supermaven-nvim",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    require("supermaven-nvim").setup({})
  end,
}
