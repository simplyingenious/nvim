require("codecompanion").setup({
  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        env = {
          api_key = vim.env.NVIM_CODE_COMPANION_OPENAI_API_KEY,
        },
      })
    end,
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = vim.env.NVIM_CODE_COMPANION_ANTHROPIC_API_KEY
        },
        schema = {
          model = {
            default = "claude-3-7-sonnet-latest"
          }
        }
      })
    end,
  },
  strategies = {
    chat = {
      adapter = 'anthropic'
    },
    inline = {
      adapter = 'anthropic'
    },
    agent = {
      adapter = 'anthropic'
    }
  },
})
