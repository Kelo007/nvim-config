local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons", version = false },
}

function M.config()
  local which_key = require("which-key")

  which_key.setup {
    win = {
      border = "none",
    },
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  }
  which_key.add {
    { "<leader>b", group = "Buffer" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>L", group = "Log" },
    -- { "<leader>s", group = "Surrounding Operator" },
  }
end

return M
