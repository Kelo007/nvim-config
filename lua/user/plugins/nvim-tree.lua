local M = {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
}

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
      enable = false,
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
          { key = "h", action = "close_node" },
          { key = "v", action = "vsplit" },
          { key = "d", action = "trash" },
          { key = "D", action = "remove" },
        },
      },
    },
    renderer = {
      group_empty = true,
    }
  }

  local keymap = require("user.utils").keymap
  keymap("n", "<leader>e", function()
    require("nvim-tree.api").tree.toggle()
  end, { desc = "Explorer" })
end

return M
