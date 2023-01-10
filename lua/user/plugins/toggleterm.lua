local M = {
  "akinsho/toggleterm.nvim",
  version = "v2.*",
  event = "VeryLazy",
}

local function set_term_opts()
  local utils = require("user.utils")
  local opts = { buffer = 0 }
  utils.keymap({ "t", "n" }, "<ScrollWheelLeft>", "<nop>", opts)
  utils.keymap({ "t", "n" }, "<ScrollWheelRight>", "<nop>", opts)

  vim.api.nvim_win_set_option(0, "number", false)
  vim.api.nvim_win_set_option(0, "relativenumber", false)
  vim.api.nvim_win_set_option(0, "scrolloff", 0)
  vim.api.nvim_win_set_option(0, "sidescrolloff", 0)
end

local function set_term_autocmd()
  local group = vim.api.nvim_create_augroup("SetTermAutoCmd", { clear = true })
  vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    pattern = "term://*",
    callback = function()
      set_term_opts()
      -- vim.api.nvim_create_autocmd("BufEnter", {
      --   buffer = 0,
      --   callback = set_term_opts,
      -- })
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
  for i, term in pairs(terminal_list) do
    vim.defer_fn(function()
      if is_open then
        term:close()
      else
        term:open()
      end
    end, (i - 1) * 5)
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
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = nil,
    autochdir = true,
    shade_terminals = false,
    direction = "float",
    float_opts = {
      border = "rounded",
    },
  }
  create_terminal("<C-\\>", "float", 100, 1)
  create_terminal("<C-0>", "vertical", 101, 1)
  create_terminal("<C-->", "horizontal", 102, 1)
  create_terminal("<C-=>", "horizontal", 103, 2)
  set_term_autocmd()
end

return M
