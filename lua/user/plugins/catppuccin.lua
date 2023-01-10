local M = {
  "catppuccin/nvim", name = "catppuccin",
  lazy = false,
  priority = 1000,
}

function M.config()
  local catppuccin = require("catppuccin")
  local U = require("catppuccin.utils.colors")
  catppuccin.setup {
    flavour = "macchiato",
    background = {
      light = "latte",
      dark = "macchiato",
    },
    term_colors = false,
    integrations = {
      cmp = true,
      hop = true,
      fidget = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      treesitter = true,
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
    custom_highlights = function(C)
      return {
        IndentBlanklineChar = { fg = C.surface1 },
        FidgetTask = { bg = C.none },
        MatchParen = { bg = C.surface2 },
        NormalFloat = { bg = C.none },
        Pmenu = { bg = C.surface0 },
        Visual = { bg = C.surface0 },
        VisualNOS = { bg = C.surface0 },
      }
    end,
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
  }
  vim.cmd.colorscheme "catppuccin-macchiato"
end

return M
