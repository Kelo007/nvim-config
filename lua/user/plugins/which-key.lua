local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local which_key = require("which-key")

  which_key.setup {
    window = {
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
  which_key.register {
    ["<leader>b"] = { name = "+Buffer" },
    ["<leader>f"] = { name = "+Find" },
    ["<leader>g"] = { name = "+Git" },
    ["<leader>l"] = { name = "+LSP" },
    ["<leader>L"] = { name = "+Log" },
    -- ["<leader>s"] = { name = "Surrounding Operator" },
  }
end

return M
