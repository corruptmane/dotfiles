--- @brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/markdown_oxide.lua

---@type vim.lsp.Config
return {
  cmd = { 'markdown-oxide' },
  filetypes = { 'markdown' },
  root_markers = { '.git', '.obsidian', '.moxide.toml' },
}
