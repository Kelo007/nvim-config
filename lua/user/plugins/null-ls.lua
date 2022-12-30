local M = {
  "jose-elias-alvarez/null-ls.nvim",
  enable = false,
}

function M.setup()
  local null_ls = require("null-ls")
  null_ls.setup {}
end

return M
