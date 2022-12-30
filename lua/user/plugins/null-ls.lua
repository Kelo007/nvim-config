local M = {
  "jose-elias-alvarez/null-ls.nvim",
  enabled = false,
}

function M.config()
  local null_ls = require("null-ls")
  null_ls.setup {}
end

return M
