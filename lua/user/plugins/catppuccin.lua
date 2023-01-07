local M = {
  "catppuccin/nvim", name = "catppuccin",
  lazy = false,
  priority = 1000,
}

function M.config()
  local catppuccin = require("catppuccin")
  catppuccin.setup {
    term_colors = true,
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
        FidgetTask = { bg = C.none, fg = C.text },
        MatchParen = { fg = C.peach, bg = C.surface2, style = { "bold" } }
        -- WhichKeyFloat = { bg = C.mantle },
      }
    end
  }
  vim.cmd.colorscheme "catppuccin"
end

return M
