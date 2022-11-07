local M = {}

function M.setup()
  require("user.plugins.lsp.mason")
  require("user.plugins.lsp.handlers").setup()
end

return M
