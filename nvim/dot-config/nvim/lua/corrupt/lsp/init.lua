local M = {}

-- Setup LSP keymaps and autocommands
function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      -- Helper function to reduce boilerplate
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map("gd", "<cmd>FzfLua lsp_definitions<cr>", "[G]oto [D]efinition")

      -- Find references for the word under your cursor.
      map("gr", "<cmd>FzfLua lsp_references<cr>", "[G]oto [R]eferences")

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map("gI", "<cmd>FzfLua lsp_implementations<cr>", "[G]oto [I]mplementation")

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map("<leader>D", "<cmd>FzfLua lsp_type_definitions<cr>", "Type [D]efinition")

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map("<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", "[D]ocument [S]ymbols")

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map("<leader>ws", "<cmd>FzfLua lsp_dynamic_workspace_symbols<cr>", "[W]orkspace [S]ymbols")

      -- Rename the variable under your cursor.
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
      map("<leader>ci", function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source.organizeImports" },
          },
          apply = true,
        })
      end, "[C]ode [I]mports")

      -- Opens a popup that displays documentation about the word under your cursor
      map("K", vim.lsp.buf.hover, "Hover Documentation")

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      -- hover/signature help in insert mode
      vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "LSP: signature help" })
      vim.keymap.set("i", "<C-S-k>", vim.lsp.buf.hover, { buffer = event.buf, desc = "LSP: hover docs" })

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- Format on save - FIX: Use buffer-local augroup to prevent duplicate autocmds
      if client and client.supports_method("textDocument/formatting") then
        local format_augroup = vim.api.nvim_create_augroup("lsp-format-" .. event.buf, { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = event.buf,
          group = format_augroup,
          callback = function()
            vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
          end,
        })
      end

      -- Document highlight - FIX: Use buffer-local augroup to prevent duplicate autocmds
      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })

  -- Diagnostics configuration
  vim.diagnostic.config({
    float = { source = "always", header = "", prefix = "" },
  })

  M.setup_servers()
end

function M.setup_servers()
  -- Load all server configurations
  local python_servers = require("corrupt.lsp.servers.python")
  local lua_servers = require("corrupt.lsp.servers.lua")
  local go_servers = require("corrupt.lsp.servers.go")
  local terraform_servers = require("corrupt.lsp.servers.terraform")
  local sql_servers = require("corrupt.lsp.servers.sql")
  local typst_servers = require("corrupt.lsp.servers.typst")

  local docker_servers = require("corrupt.lsp.servers.docker")
  local bash_servers = require("corrupt.lsp.servers.bash")
  local nginx_servers = require("corrupt.lsp.servers.nginx")

  local yaml_servers = require("corrupt.lsp.servers.yaml")
  local json_servers = require("corrupt.lsp.servers.json")
  local just_servers = require("corrupt.lsp.servers.just")
  local markdown_servers = require("corrupt.lsp.servers.markdown")

  -- Merge all server configurations
  local servers = vim.tbl_extend(
    "force",
    {},
    python_servers,
    lua_servers,
    go_servers,
    terraform_servers,
    sql_servers,
    typst_servers,
    docker_servers,
    bash_servers,
    nginx_servers,
    yaml_servers,
    json_servers,
    just_servers,
    markdown_servers
  )

  -- Get capabilities from blink.cmp
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = { ".git" },
  })

  -- Setup each LSP server
  for server_name, server_config in pairs(servers) do
    server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
    vim.lsp.config(server_name, server_config)
    vim.lsp.enable(server_name)
  end
end

return M
