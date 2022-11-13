local M = {}

function M.set_term_opts()
  vim.api.nvim_create_augroup("set_term_opts", { clear = true })
  vim.api.nvim_create_autocmd("TermOpen", {
    --pattern = "term://*toggleterm*",
    pattern = "term://*",
    callback = function()
      local utils = require("user.utils")
      local opts = { buffer = 0 }
      utils.keymap({ "t", "n" }, "<ScrollWheelLeft>", "<nop>", opts)
      utils.keymap({ "t", "n" }, "<ScrollWheelRight>", "<nop>", opts)

      vim.api.nvim_win_set_option(0, "number", false)
      vim.api.nvim_win_set_option(0, "relativenumber", false)
    end
  })
end

function M.setup()
  local toogleterm = require("toggleterm")
  toogleterm.setup {
    open_mapping = [[<c-\>]],
    autochdir = true,
    shade_terminals = false,
    insert_mappings = true,
  }
  M.set_term_opts()
end

return M
