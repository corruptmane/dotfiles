vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.wrap = false

vim.opt.undodir = os.getenv('XDG_CACHE_HOME') .. "/nvim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50
vim.opt.timeoutlen = 100

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.scrolloff = 10

vim.opt.hlsearch = true
