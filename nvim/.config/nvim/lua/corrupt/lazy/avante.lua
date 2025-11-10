return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*", -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "claude",
      -- claude = {
      --   endpoint = "https://api.anthropic.com",
      --   model = "claude-3-7-sonnet-20250219",
      --   temperature = 0,
      --   max_tokens = 4096,
      -- },
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000,  -- timeout in milliseconds
      --   temperature = 0,  -- adjust if needed
      --   max_tokens = 4096,
      --   -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      -- },
      windows = {
        -- edit = {
        --   start_insert = false,
        -- },
        ask = {
          start_insert = false,
        }
      },
    },
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",
        temperature = 0,
        max_tokens = 4096,
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000,  -- timeout in milliseconds
        temperature = 0,  -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
