--- @brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/nginx_language_server.lua

---@type table<string, vim.lsp.Config>
return {
  nginx_language_server = {
    cmd = { "nginx-language-server" },
    filetypes = { "nginx" },
    root_markers = { "nginx.conf", ".git" },
  },
}
