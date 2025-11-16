---@brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/sqls.lua

---@type table<string, vim.lsp.Config>
return {
  sqls = {
    cmd = { "sqls" },
    filetypes = { "sql", "mysql" },
    root_markers = { "config.yml" },
    settings = {},
  },
}
