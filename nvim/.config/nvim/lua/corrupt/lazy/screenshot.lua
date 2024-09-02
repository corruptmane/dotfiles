return {

  {
    "michaelrommel/nvim-silicon",
    config = function ()
      require("silicon").setup({
        font = "JetBrains Mono NL=34;Noto Color Emoji=34",
        theme = "Dracula",
        to_clipboard = true,
        output = function ()
          return os.getenv("HOME") .. "/Pictures/screenshots/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
        end
      })
      vim.keymap.set("v", "<leader>cs", ":Silicon<CR>", { desc = "[C]ode [S]napshot" })
    end
  },

}
