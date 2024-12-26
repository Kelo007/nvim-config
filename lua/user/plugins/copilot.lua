local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- event = { "VeryLazy", "InsertEnter" },
  -- a temporary workaround for blink-cmp which can not fully initialize it in time
  event = "InsertEnter",
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

  vim.schedule(function()
    local cmp = require("blink.cmp.completion.list")

    -- Handler for show event
    cmp.show_emitter:on(function()
      require("copilot.suggestion").dismiss()
      vim.api.nvim_buf_set_var(0, "copilot_suggestion_hidden", true)
    end)

    -- Handler for hide event
    cmp.hide_emitter:on(function()
      vim.api.nvim_buf_set_var(0, "copilot_suggestion_hidden", false)
    end)
  end)
end

return M
