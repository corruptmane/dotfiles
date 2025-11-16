--- @brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/marksman.lua

---@type table<string, vim.lsp.Config>
return {
  marksman = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
  },
}
