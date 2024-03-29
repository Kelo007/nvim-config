local M = {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "VeryLazy",
}

function M.config()
  local comment = require("Comment")
  local ts_comment = require("ts_context_commentstring.integrations.comment_nvim")
  local pre_hook = ts_comment.create_pre_hook()

  comment.setup {
    pre_hook = pre_hook,
  }

  -- keymap
  local api = require("Comment.api")
  local esc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
  )
  local keymap = require("user.utils").keymap
  keymap("n", "<leader>/", api.toggle.linewise.current, { desc = "Comment Toggle" })
  keymap("v", "<leader>/", function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.linewise(vim.fn.visualmode())
  end, { desc = "Comment Toggle" })
end

return M
