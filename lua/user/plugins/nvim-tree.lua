local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
}

-- copy from nvim-tree wiki: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes
local function edit_preview()
  local lib = require("nvim-tree.lib")
  local view = require("nvim-tree.view")
  -- open as vsplit on current node
  local action = "edit"
  local node = lib.get_node_at_cursor()

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
  end

  -- Finally refocus on tree if it was lost
  view.focus()
end

local function git_add()
  local lib = require("nvim-tree.lib")
  local node = lib.get_node_at_cursor()
  local gs = node.git_status.file

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)
  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  lib.refresh_tree()
end

function M.init()
  -- hijack netrw
  vim.cmd "silent! autocmd! FileExplorer *"
  vim.cmd "autocmd VimEnter * ++once silent! autocmd! FileExplorer *"
end

function M.config()
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    auto_reload_on_write = false,
    sync_root_with_cwd = true,
    diagnostics = {
      enable = true,
    },
    git = {
      enable = true,
    },
    trash = {
      -- need `trash` dependencies
      cmd = "trash ",
    },
    view = {
      width = 25,
      mappings = {
        custom_only = false,
        list = {
          { key = "H", action = "close_node" },
          { key = "L", action = "edit_preview", action_cb = edit_preview },
          { key = "v", action = "vsplit" },
          { key = "d", action = "trash" },
          { key = "D", action = "remove" },
          { key = "ga", action = "git_add", action_cb = git_add },
        },
      },
    },
    renderer = {
      group_empty = true,
      highlight_git = false,
      icons = {
        git_placement = "signcolumn",
        -- show = { git = false },
        glyphs = {
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            untracked = "U",
            renamed = "",
            deleted = "",
            ignored = "◌",
          }
        }
      }
    },
    filters = {
      custom = {
        "^.git$",
        "^node_modules$",
        "^.DS_Store$",
      }
    }
  }

  local keymap = require("user.utils").keymap
  keymap("n", "<leader>e", function()
    require("nvim-tree.api").tree.toggle()
  end, { desc = "Explorer" })
end

return M
