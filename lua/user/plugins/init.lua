return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-tree/nvim-web-devicons",

  -- colorschemes
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },

  {
    "ggandor/leap.nvim",
    enabled = false,
    config = function()
      require("leap").add_default_mappings()
      require("leap").opts.highlight_unlabeled_phase_one_targets = true
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end
  },

  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      local hop = require("hop")
      hop.setup { keys = "etovxqpdygfblzhckisuran" }
      local directions = require("hop.hint").HintDirection
      vim.keymap.set({ "n", "x" }, "s", function()
        hop.hint_words({ direction = directions.AFTER_CURSOR })
      end, { remap = true })
      vim.keymap.set({ "n", "x" }, "S", function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end, { remap = true })
    end,
    event = "VeryLazy",
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = false,
          insert_line = false,
          normal = "ygs",
          normal_cur = false,
          normal_line = false,
          normal_cur_line = false,
          visual = "gs",
          visual_line = false,
          delete = "dgs",
          change = "cgs",
        },
      })
    end,
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local indent = require("indent_blankline")
      indent.setup {
        char = "▏",
        --char = "⎸",
        show_current_context = false,
        show_current_context_start = false,
        show_trailing_blankline_indent = false,
      }
      indent.refresh(false)
    end,
    event = "VeryLazy"
  },

  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  {
    "nmac427/guess-indent.nvim",
    config = true,
    event = "BufReadPost",
  },

  -- language specific
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },
}
