---@brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/terraformls.lua
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tofu_ls.lua

---@type table<string, vim.lsp.Config>
return {
  terraformls = {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
  },
  tofu_ls = {
    cmd = { "tofu-ls", "serve" },
    filetypes = { "opentofu", "opentofu-vars", "terraform" },
    root_markers = { ".terraform", ".git" },
  },
}
