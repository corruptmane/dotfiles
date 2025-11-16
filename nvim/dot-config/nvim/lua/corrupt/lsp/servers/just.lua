---@brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/just.lua

---@type table<string, vim.lsp.Config>
return {
  just = {
    cmd = { "just-lsp" },
    filetypes = { "just" },
    root_markers = { ".git" },
  },
}
