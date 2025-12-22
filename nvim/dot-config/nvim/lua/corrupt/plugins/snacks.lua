return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local snacks = require("snacks")

    snacks.setup {
      dim = {
        enable = true,
      }
    }

    vim.keymap.set("n", "<leader>cd", function()
      if snacks.dim.enabled then
        snacks.dim.disable()
      else
        snacks.dim.enable()
      end
    end, { desc = "[C]ode [D]im" })
  end
}
