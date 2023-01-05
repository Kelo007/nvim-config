local M = {
  "akinsho/toggleterm.nvim",
  version = "v2.*",
  event = "VeryLazy",
}

local function set_term_opts()
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

local function any_terminal_open(terminal_list)
  local is_open = false
  for _, term in pairs(terminal_list) do
    if term:is_open() then
      is_open = true
      break
    end
  end
  return is_open
end

local function toggle_all_terminal(terminal_list)
  local is_open = any_terminal_open(terminal_list)
  for _, term in pairs(terminal_list) do
    if is_open then
      term:close()
    else
      term:open()
    end
  end
end

local function create_terminal(open_mapping, direction, count, number)
  if number == nil then
    number = 1
  end
  local Terminal = require("toggleterm.terminal").Terminal
  local utils = require("user.utils")
  local terminal_list = {}
  local toggle_func = function()
    toggle_all_terminal(terminal_list)
  end
  for i = 1, number do
    terminal_list[i] = Terminal:new({
      direction = direction,
      count = count + i,
      on_open = function(term)
        utils.keymap("t", open_mapping, toggle_func, { buffer = term.bufnr })
        -- utils.keymap("n", "<leader>q", function() term:close() end, { buffer = term.bufnr, desc = "Close Terminal" })
        -- utils.keymap("n", "<leader>c", function() term:shutdown() end, { buffer = term.bufnr, desc = "Close Terminal" })
      end,
    })
  end
  utils.keymap("n", open_mapping, toggle_func)
end

function M.config()
  local toogleterm = require("toggleterm")
  toogleterm.setup {
    open_mapping = [[<nop>]],
    autochdir = true,
    shade_terminals = false,
    direction = "float",
    float_opts = {
      border = "rounded",
    },
  }
  create_terminal("<C-\\>", "float", 100, 1)
  create_terminal("<C-8>", "vertical", 101, 1)
  create_terminal("<C-9>", "horizontal", 102, 1)
  create_terminal("<C-0>", "horizontal", 103, 2)
  set_term_opts()
end

return M
