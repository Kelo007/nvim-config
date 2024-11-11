local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", tag="legacy" },
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  event = { "VeryLazy", "InsertEnter" },
}

function M.config()
  require("user.plugins.lsp.mason")
  require("user.plugins.lsp.handlers").setup()
  require("mason-null-ls").setup {
    automatic_installation = false,
    automatic_setup = true,
    handlers = {},
  }
  require("null-ls").setup()
  require("fidget").setup {
    sources = {
      ["null-ls"] = {
        ignore = true,
      },
    },
  }
  vim.cmd("silent! do FileType")
end

return M
