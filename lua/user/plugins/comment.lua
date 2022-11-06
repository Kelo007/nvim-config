local M = {}

M.setup = function ()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  local pre_hook
  local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
  if loaded and ts_comment then
    pre_hook = ts_comment.create_pre_hook()
  end

  comment.setup {
    pre_hook = pre_hook,
  }

  -- keymap
  local api = require("Comment.api")
  local esc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
  )
  local k = require("user.utils").keymap
  k("n", "<leader>/", api.toggle.linewise.current, { desc = "Comment Toggle" })
  k("v", "<leader>/", function ()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.linewise(vim.fn.visualmode())
  end, { desc = "Comment Toggle" })
end

return M

