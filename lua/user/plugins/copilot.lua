local M = {
  "Kelo007/copilot.lua",
  cmd = "Copilot",
}

function M.config()
  require("copilot").setup {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        next = "<C-j>",
        prev = "<C-k>",
        dismiss = "<C-e>",
      }
    }
  }
  local cmp = require("cmp")
  local schedule = require("copilot.suggestion").schedule
  cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
    schedule()
  end)
  cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
    schedule()
  end)
end

return M
