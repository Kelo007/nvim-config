local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
}

local function spaces()
  local expandtab = vim.api.nvim_buf_get_option(0, "expandtab")
  return (expandtab and "S" or "T") .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function get_theme()
  -- onedark
  -- local onedark = require("lualine.themes.onedark")
  -- onedark.normal.c.fg = "#95a0b5"
  -- palette
  local catppuccin = require("lualine.themes.catppuccin")
  local palette = require("catppuccin.palettes").get_palette()
  catppuccin.normal.b.fg = palette.subtext1
  catppuccin.normal.c.fg = palette.subtext0
  return catppuccin
end

function M.config()
  local lualine = require("lualine")
  lualine.setup {
    options = {
      icons_enabled = true,
      section_separators = "",
      component_separators = "",
      theme = get_theme(),
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "fileformat", spaces, "encoding" },
      lualine_y = { "filetype" },
      lualine_z = { "location" }
    },
  }
  -- disyplay delay bug included in lazy.vim: https://github.com/folke/lazy.nvim/commit/5aca9280df4245df8bf8e33fe9bc4ce85507dc31
  -- refresh here, fix the bug temporarily
  -- 2023-07-28: no longer needed in new machine
  -- require("lualine").refresh()
end

return M
