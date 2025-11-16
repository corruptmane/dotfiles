--- @brief
--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/yamlls.lua

---@type table<string, vim.lsp.Config>
return {
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    root_markers = { ".git" },
    on_init = function(client)
      --- https://github.com/neovim/nvim-lspconfig/pull/4016
      --- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
      --- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
      --- autocmd's which check this capability
      client.server_capabilities.documentFormattingProvider = true
    end,
    settings = {
      yaml = {
        schemas = {
          ["kubernetes"] = "k8s-*.yaml",
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
          ["https://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
          ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["https://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
          ["https://golangci-lint.run/jsonschema/golangci.jsonschema.json"] = ".golangci.yml",
        },
        format = { enable = true },
      },
    },
  },
}
