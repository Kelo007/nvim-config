local M = {
  "Kelo007/copilot.lua",
  cmd = "Copilot",
  enabled = false,
}

function M.config()
  require("copilot").setup {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = nil,
        next = nil,
        prev = nil,
        dismiss = nil,
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
