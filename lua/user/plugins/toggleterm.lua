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
    pattern = "term://*",
    callback = function ()
      local utils = require("user.utils")
      local opts = { buffer = 0 }
      utils.keymap("t", "<esc>", [[<C-\><C-n>]], opts)
      utils.keymap("t", "jj", [[<C-\><C-n>]], opts)
      utils.keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
      utils.keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
      utils.keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
      utils.keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
      utils.keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
    end
  })
end

return M

