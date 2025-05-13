local float_style = {
  style = "minimal",
  border = "rounded",
  source = "always",
}
function on_attach(client, bufnr)
  local keymap = require("user.utils").keymap
  keymap("n", "K", function()
    vim.lsp.buf.hover(float_style)
  end, { buffer = bufnr, desc = "LSP Hover" })
  keymap("n", "gs", function()
    vim.lsp.buf.signature_help(float_style)
  end, { buffer = bufnr, desc = "LSP Signature Help" })
  keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Definition" })
  keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP Declaration" })
  keymap("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP Implementation" })
  keymap("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP References" })
  keymap("n", "gl", function()
    local float_config = vim.tbl_extend("force", float_style, {
      scope = "line",
    })
    vim.diagnostic.open_float(float_config)
  end, { buffer = bufnr, desc = "LSP Line Diagnostics", })
  keymap("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code Action" })
  keymap("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, desc = "LSP Format" })
  keymap("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP Rename" })
  keymap("n", "<leader>lq", vim.diagnostic.setloclist, { buffer = bufnr, desc = "LSP Diagnostics" })
  keymap("n", "<leader>lA", vim.lsp.codelens.run, { buffer = bufnr, desc = "LSP CodeLens" })
  keymap("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "LSP Next Diagnostic" })
  keymap("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "LSP Previous Diagnostic" })

  if client.supports_method("textDocument/inlayHint", { bufnr = bufnr }) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end
local M = {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            on_attach(client, bufnr)
          end
        end,
      })
    end,
    keys = {
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" },
      { "<leader>Ll", "<cmd>LspLog<cr>", desc = "LSP Logfile" },
    }
  }
}

return M
