return {

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
      { 'saghen/blink.cmp' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper function to reduce boilerplate
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', '<cmd>FzfLua lsp_definitions<cr>', '[G]oto [D]efinition')


          -- Find references for the word under your cursor.
          map('gr', '<cmd>FzfLua lsp_references<cr>', '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', '<cmd>FzfLua lsp_implementations<cr>', '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', '<cmd>FzfLua lsp_type_definitions<cr>', 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', '<cmd>FzfLua lsp_document_symbols<cr>', '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', '<cmd>FzfLua lsp_dynamic_workspace_symbols<cr>', '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')
          map('<leader>ci', function()
            vim.lsp.buf.code_action({
              context = {
                only = { "source.organizeImports" }
              },
              filter = function(action)
                return action.title == "Ruff: Organize imports"
              end,
              apply = true,
            })
          end, '[C]ode [I]mports')

          -- Opens a popup that displays documentation about the word under your cursor
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- hover/signature help in insert mode
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: signature help' })
          vim.keymap.set('i', '<C-S-k>', vim.lsp.buf.hover, { buffer = event.buf, desc = 'LSP: hover docs' })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd(
              'BufWritePre',
              {
                buffer = event.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
                end
              }
            )
          end
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities)

      local servers = {
        pyright = {
          -- Disable formatting for pyright
          settings = {
            python = {
              formatting = {
                provider = "none"
              }
            }
          }
        },
        ruff = {
          init_options = {
            settings = {
              configurationPreference = "filesystemFirst",
              organizeImport = true,
              lineLength = 79,
              format = {
                preview = true,
              }
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ['kubernetes'] = 'k8s-*.yaml',
                ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
                ['https://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] =
                'docker-compose*.{yml,yaml}',
                ['https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json'] =
                'argocd-application.yaml',
                ['https://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/**/*.{yml,yaml}',
                ['https://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                ['https://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                ['https://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                ['https://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
                ['https://golangci-lint.run/jsonschema/golangci.jsonschema.json'] = '.golangci.yml',
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run `:Mason`
      require('mason').setup()

      -- Diagnostics configuration
      vim.diagnostic.config({
        float = { source = "always", header = "", prefix = "" }
      })

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',  -- Used to format Lua code
        'pyright', -- Python LSP
        'ruff',    -- Python LSP and formatter
        'yamlls',  -- YAML LSP
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

}
