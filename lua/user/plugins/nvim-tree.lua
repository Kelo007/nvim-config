local M = {}

function M.setup()
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
    },
    auto_reload_on_write = false,
    sync_root_with_cwd = true,
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = false,
      update_root = true,
    },
    git = {
      enable = false,
      ignore = true,
      timeout = 500,
    },
    trash = {
      -- need `trash` dependencies
      cmd = "trash ",
      require_confirm = true,
    },
    view = {
      width = 25,
      hide_root_folder = false,
      side = "left",
      mappings = {
        custom_only = false,
        list = {
          --{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", action = "close_node" },
          { key = "v", action = "vsplit" },
        },
      },
    },
    renderer = {
      highlight_git = false,
      --root_folder_modifier = ":t",
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
        }
      }
    }
  }

  local k = require("user.utils").keymap
  k("n", "<leader>e", function()
    require("nvim-tree.api").tree.toggle()
  end, { desc = "Explorer" })
end

return M
