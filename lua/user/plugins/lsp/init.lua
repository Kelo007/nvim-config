local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
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
  }
  require("null-ls").setup()
  require("mason-null-ls").setup_handlers()
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
