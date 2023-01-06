local M = {
  "zbirenbaum/copilot.lua",
  event = { "InsertEnter", "VeryLazy" },
}

function M.config()
  vim.schedule(function()
    require("copilot").setup()
    local cmp = require("cmp")
    cmp.event:on("menu_opened", function()
      vim.b.copilot_suggestion_hidden = true
    end)

    cmp.event:on("menu_closed", function()
      vim.b.copilot_suggestion_hidden = false
    end)
  end)
end

return M
