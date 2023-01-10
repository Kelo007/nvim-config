vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {
      higroup = "CurSearch",
      timeout = 200,
    }
  end,
})
