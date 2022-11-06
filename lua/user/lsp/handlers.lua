local M = {}
local utils = require("user.utils")

local float = {
  focusable = false,
  style = "minimal",
  border = "rounded",
  source = "always",
  header = "",
  prefix = "",
}

local config = {
  document_highlight = false,
  code_lens_refresh = false,
  --vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  --vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  --vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  --vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  --vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
  --vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  ---- vim.api.nvim_buf_set_keymap(bufnr, "n  ", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  ---- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  ---- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  --vim.api.nvim_buf_set_keymap(
  --  bufnr,
  --  "n",
  --  "gl",
  --  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
  --  opts
  --)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  --vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  keymap = {
    {"K", vim.lsp.buf.hover},
    {"gd", vim.lsp.buf.definition, { desc = "Definition" }},
    {"gD", vim.lsp.buf.declaration, { desc = "Declaration" }},
    {"gI", vim.lsp.buf.implementation, { desc = "implementation" }},
    {"gs", vim.lsp.buf.signature_help, { desc = "Signature Help" }},
    {"gr", vim.lsp.buf.references, { desc = "References" }},
    {"gl",
      function ()
        local float_config = vim.tbl_extend("force", float, {
          scope = "line",
        })
        vim.diagnostic.open_float(0, float_config)
      end,
      { desc = "Line Diagnostics" }
    },
    { "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" }},
    { "<leader>lf", vim.lsp.buf.format, { desc = "Format" }},
    { "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" }},
    { "<leader>lI", "<cmd>Mason<cr>", { desc = "Mason Info" }},
    { "<leader>lj", vim.diagnostic.goto_next, { desc = "Next Diagnostic" }},
    { "<leader>lk", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" }},
    { "<leader>lA", vim.lsp.codelens.run, { desc = "CodeLens Action" }},
    { "<leader>lq", vim.diagnostic.setloclist, { desc = "Quickfix" }},
    { "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" }},
  },
  diagnostic = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = float,
  },
}

M.setup = function()
  for _, sign in ipairs(config.diagnostic.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config(config.diagnostic)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

local function lsp_highlight_document(client, bufnr)
  local status_ok, highlight_supported = pcall(function()
    return client.supports_method "textDocument/documentHighlight"
  end)
  if not status_ok or not highlight_supported then
    return
  end
  local group = "lsp_document_highlight"
  local hl_events = { "CursorHold", "CursorHoldI" }

  local ok, hl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = hl_events,
  })

  if ok and #hl_autocmds > 0 then
    return
  end

  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(hl_events, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

local function lsp_codelens(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method "textDocument/codeLens"
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = "lsp_code_lens_refresh"
  local cl_events = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })

  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

local function lsp_keymaps(bufnr)
  local k = require("user.utils").keymap
  for _, keymap in pairs(config.keymap) do
    local opts = keymap[3] and keymap[3] or {}
    opts = vim.tbl_extend("force", opts, { buffer = bufnr })
    k("n", keymap[1], keymap[2], opts)
  end

  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  if config.document_highlight then
    lsp_highlight_document(client)
  end
  if config.code_lens_refresh then
    lsp_codelens(client, bufnr)
  end
end

M.on_exit = function(_, _)
  if config.document_highlight then
    utils.clear_augroup "lsp_document_highlight"
  end
  if config.code_lens_refresh then
    utils.clear_augroup "lsp_code_lens_refresh"
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return M

