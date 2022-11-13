local M = {}

function M.setup()
  local toogleterm = require("toggleterm")
  toogleterm.setup {
    open_mapping = [[<c-\>]],
    autochdir = true,
    shade_terminals = false,
    insert_mappings = true,
  }
  vim.api.nvim_create_augroup("toggle_terminal_keymap", { clear = true })
  vim.api.nvim_create_autocmd("TermOpen", {
    --pattern = "term://*toggleterm*",
    pattern = "term://*",
    callback = function()
      local utils = require("user.utils")
      local opts = { buffer = 0 }
      utils.keymap({ "t", "n" }, "<ScrollWheelLeft>", "<nop>", opts)
      utils.keymap({ "t", "n" }, "<ScrollWheelRight>", "<nop>", opts)
    end
  })
end

return M
