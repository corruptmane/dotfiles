return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- version = 'v0.9.3',
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      local opts = {
        ensure_installed = {
          "bash",
          "awk",
          "diff",
          "json",
          "jsonc",
          "yaml",
          "ini",
          "toml",
          "xml",
          "jq",
          "dockerfile",
          "editorconfig",
          "caddy",
          "nginx",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "vim",
          "vimdoc",
          "python",
          "go",
          "typst",
          "terraform",
          "regex",
          "just",
          "make",
          "sql",
          "ssh_config",
          "tmux",
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          disable = function(_, buf)
            local max_filesize = 1024 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
            return false
          end,
          additional_vim_regex_highlighting = { "ruby" },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select around a function" },
              ["if"] = { query = "@function.inner", desc = "Select inside a function" },
              ["ac"] = { query = "@class.outer", desc = "Select around a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inside a class" },
            },
            include_surrounding_whitespace = true,
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>cs"] = "@parameter.inner" },
            swap_previous = { ["<leader>cS"] = "@parameter.inner" },
          },
        },
        indent = { enable = true, disable = { "ruby" } },
      }

      require("nvim-treesitter.configs").setup(opts)

      require("treesitter-context").setup({
        max_lines = 20,
        multiline_threshold = 3,
      })
    end,
  },

  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "_", "<cmd>AerialPrev<cr>", { buffer = bufnr })
          vim.keymap.set("n", "+", "<cmd>AerialNext<cr>", { buffer = bufnr })
        end,
      })
      vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<cr>", { desc = "[T]earch [A]erial" })
    end,
  },
}
