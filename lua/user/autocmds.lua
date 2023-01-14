-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close lspinfo popup and help,qf buffers with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lspinfo", "lsp-installer", "null-ls-info", "help", "qf", "man" },
  callback = function()
    local opts = { buffer = true, silent = true, nowait = true, desc = "close lspinfo popup and help,qf buffers" }
    vim.keymap.set("n", "q", function()
      vim.cmd.close()
    end, opts)
  end,
  desc = "close lspinfo popup and help,qf buffers with q",
})

-- create missing parent directories automatically
vim.api.nvim_create_autocmd("BufNewFile", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      once = true,
      callback = function()
        local path = vim.fn.expand "%:h"
        local p = require("plenary.path"):new(path)
        if not p:exists() then
          p:mkdir { parents = true }
        end
      end,
      desc = "create missing parent directories automatically",
    })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search", timeout = 250
    }
  end,
})
