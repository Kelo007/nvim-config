local M = {}

M.setup = function ()
  local gitsigns = require("gitsigns")
  gitsigns.setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
  }

  local k = require("user.utils").keymap
  k("n", "<leader>gj", function ()
    gitsigns.next_hunk({ navigation_message = false })
  end, { desc = "Next Hunk" })
  k("n", "<leader>gk", function ()
    gitsigns.prev_hunk({ navigation_message = false })
  end, { desc = "Prev Hunk" })
  k("n", "<leader>gp", function ()
    gitsigns.preview_hunk()
  end, { desc = "Preview Hunk" })
  k("n", "<leader>gr", function ()
    gitsigns.reset_hunk()
  end, { desc = "Reset Hunk" })
  k("n", "<leader>gR", function ()
    gitsigns.reset_buffer()
  end, { desc = "Reset Buffer" })
  k("n", "<leader>gs", function ()
    gitsigns.stage_hunk()
  end, { desc = "Stage Hunk" })
  k("n", "<leader>gu", function ()
    gitsigns.undo_stage_hunk()
  end, { desc = "Undo Stage Hunk" })
  k("n", "<leader>gd", function ()
    gitsigns.diffthis("HEAD")
  end, { desc = "Git Diff" })
  k("n", "<leader>gb", function ()
    gitsigns.blame_line()
  end, { desc = "Blame" })
end

return M
