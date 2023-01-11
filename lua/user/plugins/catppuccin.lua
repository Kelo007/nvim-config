local M = {
  "catppuccin/nvim", name = "catppuccin",
  lazy = false,
  priority = 1000,
}

function M.config()
  local catppuccin = require("catppuccin")
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
      illuminate = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
    custom_highlights = function(C)
      return {
        IndentBlanklineChar = { fg = C.surface1 },
        FidgetTask = { bg = C.none },
        NvimTreeWinSeparator = { bg = C.mantle, fg = C.mantle },
        NvimTreeGitDirty = { fg = C.yellow, style = { "underdotted" }},
        NvimTreeGitNew = { fg = C.blue, style = { "underline" } },
        NvimTreeGitDeleted = { fg = C.red, style = { "undercurl" } },
        MatchParen = { bg = C.surface2 },
        NormalFloat = { bg = C.none },
        Pmenu = { bg = C.surface0 },
        Visual = { bg = C.surface0 },
        VisualNOS = { bg = C.surface0 },
      }
    end,
  }
  vim.cmd.colorscheme "catppuccin-macchiato"
end

return M
