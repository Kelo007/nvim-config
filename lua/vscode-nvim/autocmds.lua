local function augroup(name)
  return vim.api.nvim_create_augroup("user_augroup_" .. name, { clear = true })
end

-- do not insert comments when press o
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("do_not_insert_comments_when_press_o"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove "o"
  end,
  desc = "do not insert comments when press o",
})
