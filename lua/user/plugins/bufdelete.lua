local M = {}

function M.setup()
  local bufdelete = require("bufdelete")
  local k = require("user.utils").keymap
  k("n", "<leader>q", function()
    bufdelete.bufdelete(0, false)
  end, { desc = "Close Buffer" })
end

return M

