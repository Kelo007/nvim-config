local M = {}

function M.setup()
  local bufferline = require("bufferline")

  bufferline.setup {
    options = {
      mode = "buffers",
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions" right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete %d", -- can be a string | function, see "Mouse actions"
      show_buffer_icons = false,
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      diagnostics = false,
      indicator = {
        icon = '', -- this should be omitted if indicator style is not 'icon'
        style = 'icon',
      },
      offsets = {
        {
          filetype = "undotree",
          text = "Undotree",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "DiffviewFiles",
          text = "Diff View",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          highlight = "PanelHeading",
        },
        {
          filetype = "packer",
          text = "Packer",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
      hover = {
        enabled = false,
        delay = 200,
        reveal = { "close" }
      },
      separator_style = "thin",
      tab_size = 20,
      sort_by = "id",
    },
  }

  local k = require("user.utils").keymap;

  k("n", "<leader>bj", bufferline.pick_buffer, { desc = "Jump" })
  k("n", "<leader>bw", bufferline.close_buffer_with_pick, { desc = "Pick which buffer to close" })
  k("n", "<leader>bl", function() bufferline.cycle(1) end, { desc = "Next" })
  k("n", "<leader>bh", function() bufferline.cycle(-1) end, { desc = "Previous" })
  k("n", "<leader>bp", function() bufferline.close_in_direction("left") end, { desc = "Close all to the left" })
  k("n", "<leader>bn", function() bufferline.close_in_direction("right") end, { desc = "Close all to the right" })
end

return M

