return {

  { -- Useful plugin to show pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function()
      local wk = require('which-key')
      wk.setup()

      -- Document existing key chains
      wk.register(
        {
          ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        },
        { mode = 'v' }
      )
      wk.register(
        {
          ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
          ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
          ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
          ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
          ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
          ['<leader>p'] = { name = '[P]roject', _ = 'which_key_ignore' },
          ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        },
        { mode = 'n' }
      )
    end,
  },

}
