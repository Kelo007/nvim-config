local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    }
  },
  event = "VeryLazy",
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["q"] = actions.close,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  }

  require('telescope').load_extension('fzf')

  local builtin = require('telescope.builtin')
  local themes = require("telescope.themes")
  local dropdown_theme = themes.get_dropdown
  local ivy_theme = themes.get_ivy

  local keymap = require("user.utils").keymap
  keymap("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
  keymap("n", "<leader>ff", builtin.find_files, { desc = "Find File" })
  keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
  keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
  keymap("n", "<leader>fH", builtin.highlights, { desc = "Find highlight groups" })
  keymap("n", "<leader>fM", builtin.man_pages, { desc = "Man Pages" })
  keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
  keymap("n", "<leader>fR", builtin.registers, { desc = "Registers" })
  keymap("n", "<leader>ft", builtin.live_grep, { desc = "Text" })
  keymap("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
  keymap("n", "<leader>fc", builtin.commands, { desc = "Commands" })

  keymap("n", "<leader>p", function()
    builtin.find_files(dropdown_theme { previewer = false })
  end, { desc = "Find Files" })

  keymap("n", "<leader>ld", function()
    builtin.diagnostics(ivy_theme { bufnr = 0 })
  end, { desc = "Buffer Diagnostics" })
  keymap("n", "<leader>lD", function()
    builtin.diagnostics(ivy_theme {})
  end, { desc = "Project Diagnostics" })
  keymap("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Buffer Symbols" })
  keymap("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, { desc = "Project Symbols" })
  keymap("n", "<leader>lQ", builtin.quickfix, { desc = "Telescope Quickfix" })

  keymap("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
  keymap("n", "<leader>gb", builtin.git_status, { desc = "Git Branches" })
  keymap("n", "<leader>gc", builtin.git_status, { desc = "Git Commits" })

  keymap("n", "<leader>t", builtin.lsp_document_symbols, { desc = "Buffer Symbols" })
  keymap("n", "<leader>T", builtin.lsp_dynamic_workspace_symbols, { desc = "Project Symbols" })

  keymap("n", "<leader>bf", builtin.buffers, { desc = "Find Buffers" })

  keymap("n", "<leader>Lt", function()
    require("user.utils").open_logfile("telescope.log")
  end, { desc = "Telescope Log" })
end

return M
