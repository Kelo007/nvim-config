local M = {}

local function spaces()
  local expandtab = vim.api.nvim_buf_get_option(0, "expandtab")
  return (expandtab and "S" or "T") .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

function M.setup()
  local lualine = require("lualine")
  -- change onedark theme
  local onedark = require("lualine.themes.onedark")
  -- fg
  onedark.normal.c.fg = "#95a0b5"
  lualine.setup {
    options = {
      icons_enabled = true,
      section_separators = "",
      component_separators = "",
      theme = onedark,
      --disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
      globalstatus = true,
    },
    sections = {
      lualine_a = {"mode"},
      lualine_b = {"branch", "diagnostics"},
      lualine_c = {"filename"},
      lualine_x = {"fileformat", spaces, "encoding"},
      lualine_y = {"filetype"},
      lualine_z = {"location"}
    },
  }
end

return M

