local M = {}

function M.setup()
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
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  }

  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')

  local builtin = require('telescope.builtin')
  local themes = require("telescope.themes")
  local dropdown_theme = themes.get_dropdown
  local ivy_theme = themes.get_ivy

  local k = require("user.utils").keymap
  k("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
  k("n", "<leader>ff", builtin.find_files, { desc = "Find File" })
  k("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
  k("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
  k("n", "<leader>fH", builtin.highlights, { desc = "Find highlight groups" })
  k("n", "<leader>fM", builtin.man_pages, { desc = "Man Pages" })
  k("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
  k("n", "<leader>fR", builtin.registers, { desc = "Registers" })
  k("n", "<leader>ft", builtin.live_grep, { desc = "Text" })
  k("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
  k("n", "<leader>fc", builtin.commands, { desc = "Commands" })

  k("n", "<leader>p", function ()
    builtin.find_files(dropdown_theme { previewer = false })
  end, { desc = "Find Files" })

  k("n", "<leader>ld", function ()
    builtin.diagnostics(ivy_theme { bufnr = 0 })
  end, { desc = "Buffer Diagnostics" })
  k("n", "<leader>lD", function ()
    builtin.diagnostics(ivy_theme {})
  end, { desc = "Project Diagnostics" })
  k("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Buffer Symbols" })
  k("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, { desc = "Project Symbols" })
  k("n", "<leader>lQ", builtin.quickfix, { desc = "Telescope Quickfix" })

  k("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
  k("n", "<leader>gb", builtin.git_status, { desc = "Git Branches" })
  k("n", "<leader>gc", builtin.git_status, { desc = "Git Commits" })

  k("n", "<leader>t", builtin.lsp_document_symbols, { desc = "Buffer Symbols" })
  k("n", "<leader>T", builtin.lsp_dynamic_workspace_symbols, { desc = "Project Symbols" })

  k("n", "<leader>bf", builtin.buffers, { desc = "Find Buffers" })
end

return M

