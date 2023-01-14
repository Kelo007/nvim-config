local M = {
  "akinsho/bufferline.nvim",
  version = "v3.*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
}

function M.config()
  local bufferline = require("bufferline")

  bufferline.setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      close_command = "Bdelete! %d",
      left_mouse_command = "buffer %d",
      right_mouse_command = "Bdelete %d",
      show_buffer_icons = false,
      diagnostics = false,
      indicator = {
        icon = "▏",
        style = "icon",
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
      hover = {
        enabled = false,
      },
      tab_size = 20,
      sort_by = "id",
    },
  }

  local keymap = require("user.utils").keymap;

  keymap("n", "<leader>bj", bufferline.pick_buffer, { desc = "Jump" })
  keymap("n", "<leader>bw", bufferline.close_buffer_with_pick, { desc = "Pick which buffer to close" })
  keymap("n", "<leader>bl", function() bufferline.cycle(1) end, { desc = "Next" })
  keymap("n", "<leader>bh", function() bufferline.cycle(-1) end, { desc = "Previous" })
  keymap("n", "<leader>bH", function() bufferline.go_to_buffer(1, true) end, { desc = "Go to first buffer" })
  keymap("n", "<leader>bL", function() bufferline.go_to_buffer(-1, true) end, { desc = "Go to last buffer" })
  keymap("n", "<leader>b[", function() bufferline.close_in_direction("left") end, { desc = "Close all to the left" })
  keymap("n", "<leader>b]", function() bufferline.close_in_direction("right") end, { desc = "Close all to the right" })
end

return M
