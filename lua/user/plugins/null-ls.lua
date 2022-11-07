local M = {}

function M.setup()
  local null_ls = require("null-ls")
  null_ls.setup {}
end

return M
