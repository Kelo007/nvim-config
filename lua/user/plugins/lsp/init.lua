local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
  },
  event = { "VeryLazy", "InsertEnter" },
}

function M.config()
  require("user.plugins.lsp.mason")
  require("user.plugins.lsp.handlers").setup()
  require("fidget").setup()
  vim.cmd "silent! do FileType"
end

return M
