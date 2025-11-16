--- @brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/docker_language_server.lua

---@type table<string, vim.lsp.Config>
return {
  docker_language_server = {
    cmd = { "docker-language-server", "start", "--stdio" },
    filetypes = { "dockerfile", "yaml.docker-compose" },
    get_language_id = function(_, ftype)
      if ftype == "yaml.docker-compose" or ftype:lower():find("ya?ml") then
        return "dockercompose"
      else
        return ftype
      end
    end,
    root_markers = {
      "Dockerfile",
      "docker-compose.yaml",
      "docker-compose.yml",
      "compose.yaml",
      "compose.yml",
      "docker-bake.json",
      "docker-bake.hcl",
      "docker-bake.override.json",
      "docker-bake.override.hcl",
    },
  },
}
