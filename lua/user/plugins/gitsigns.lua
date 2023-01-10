local M = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
}

function M.config()
  local gitsigns = require("gitsigns")
  gitsigns.setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    preview_config = {
      border = "rounded",
    },
  }

  local keymap = require("user.utils").keymap
  keymap("n", "<leader>gj", function()
    gitsigns.next_hunk({ navigation_message = false })
  end, { desc = "Next Hunk" })
  keymap("n", "<leader>gk", function()
    gitsigns.prev_hunk({ navigation_message = false })
  end, { desc = "Prev Hunk" })
  keymap("n", "<leader>gp", function()
    gitsigns.preview_hunk()
  end, { desc = "Preview Hunk" })
  keymap("n", "<leader>gr", function()
    gitsigns.reset_hunk()
  end, { desc = "Reset Hunk" })
  keymap("n", "<leader>gR", function()
    gitsigns.reset_buffer()
  end, { desc = "Reset Buffer" })
  keymap("n", "<leader>gs", function()
    gitsigns.stage_hunk()
  end, { desc = "Stage Hunk" })
  keymap("n", "<leader>gu", function()
    gitsigns.undo_stage_hunk()
  end, { desc = "Undo Stage Hunk" })
  keymap("n", "<leader>gd", function()
    gitsigns.diffthis("HEAD")
  end, { desc = "Git Diff" })
  keymap("n", "<leader>gb", function()
    gitsigns.blame_line()
  end, { desc = "Blame" })
  keymap("n", "]g", function()
    gitsigns.next_hunk({ navigation_message = false })
  end, { desc = "Next Hunk" })
  keymap("n", "[g", function()
    gitsigns.prev_hunk({ navigation_message = false })
  end, { desc = "Prev Hunk" })
end

return M
