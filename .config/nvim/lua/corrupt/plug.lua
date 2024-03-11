local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

Plug('navarasu/onedark.nvim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { branch = '0.1.x' })

Plug('nvim-treesitter/nvim-treesitter', {
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
})
Plug('nvim-treesitter/playground')

Plug('theprimeagen/harpoon')

Plug('christoomey/vim-tmux-navigator')

Plug('jiaoshijie/undotree')

Plug('tpope/vim-fugitive')

-- LSP and auto-completion
-- ########
Plug('VonHeikemen/lsp-zero.nvim', { branch = 'v3.x' })
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lua')
Plug('L3MON4D3/LuaSnip')
Plug('rafamadriz/friendly-snippets')
-- ########

Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

Plug('ap/vim-css-color')

Plug('tpope/vim-commentary')

Plug('unblevable/quick-scope')

Plug('tpope/vim-surround')

Plug('github/copilot.vim')
Plug('wakatime/vim-wakatime')

Plug('folke/trouble.nvim', {
    config = function ()
        require('trouble').setup {
            icons = true,
            use_diagnostic_signs = true
        }
    end,
})

Plug('nvim-treesitter/nvim-treesitter-context')
Plug('folke/zen-mode.nvim')

vim.call('plug#end')

