--- @brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/jsonls.lua

---@type table<string, vim.lsp.Config>
return {
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = true,
    },
    root_markers = { ".git" },
  },
}
