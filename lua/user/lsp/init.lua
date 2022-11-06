local M = {}

function M.setup()
  require("user.lsp.mason")
  require("user.lsp.handlers").setup()
end

return M

