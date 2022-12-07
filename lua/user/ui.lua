local M = {}

function M.setup()
  local cmds = [[
    nohls
    lang en_US
  ]]

  -- it may fall, so use pcall
  pcall(vim.cmd, cmds)

  -- load colorscheme
  local status_ok, onedark = pcall(require, "onedark")
  if not status_ok then
    return
  end

  onedark.setup {
    style = "cool",
    highlights = {
      -- fg = c.fg, bg = c.dark_cyan
      Search = { fg = "#a5b0c5", bg = "#25747d" },
      -- fg = c.bg0, bg = c.orange
      IncSearch = { fg = "#242b38", bg = "#d99a5e" },
      ["@field"] = { fg = "#ef5f6b" },
      ["@property"] = { fg = "#ef5f6b" },
    },
  }
  onedark.load()
  vim.api.nvim_set_hl(0, "CurSearch", { link = "IncSearch" })
end

return M

