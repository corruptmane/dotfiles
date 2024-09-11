return {

  { -- Useful plugin to show pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    -- config = function()
    --   local wk = require('which-key')
    --   wk.setup()
    --
    --   -- Document existing key chains
    -- end,
    opts = {
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>p', group = '[P]roject' },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
      }
    }
  },

}
