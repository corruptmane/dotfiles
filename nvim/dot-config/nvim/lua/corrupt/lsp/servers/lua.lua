---@brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/stylua.lua

---@type table<string, vim.lsp.Config>
return {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".emmyrc.json",
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    },
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
  stylua = {
    cmd = { "stylua", "--lsp" },
    filetypes = { "lua" },
    root_markers = { ".stylua.toml", "stylua.toml", ".editorconfig" },
  },
}
