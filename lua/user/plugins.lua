local M = {}

function M.setup()
  local putils = require("user.plugins.utils")

  local packer_bootstrap = putils.ensure_packer_installed()
  local packer = require("packer")
  -- Have packer use a popup window
  packer.init({
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  })

  -- Install your plugins here
  packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("lewis6991/impatient.nvim")
    use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
--    use("antoinemadec/FixCursorHold.nvim")

    -- Colorschemes
    --use("lunarvim/onedarker.nvim")
    use("navarasu/onedark.nvim")
    --use("folke/tokyonight.nvim")
    --use("rebelot/kanagawa.nvim")

    -- bufdelete
    use {
      "famiu/bufdelete.nvim",
      config = function ()
        require("user.plugins.bufdelete").setup()
      end
    }

    -- nvim-tree
    use("nvim-tree/nvim-web-devicons")
    use {
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      config = function ()
        require("user.plugins.nvim-tree").setup()
      end,
      event = {"CursorHold", "VimEnter"},
    }

    -- bufferline
    use {
      "akinsho/bufferline.nvim",
      tag = "v3.*",
      requires = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim"},
      config = function ()
        require("user.plugins.bufferline").setup()
      end,
    }

    ---- lualine
    use {
      "nvim-lualine/lualine.nvim",
      requires = { "nvim-tree/nvim-web-devicons", opt = true },
      config = function ()
        require("user.plugins.lualine").setup()
      end,
    }

    -- cmp
    use {
      "rafamadriz/friendly-snippets",
      event = { "InsertEnter", "CursorHold" },
    }
    use {
      "L3MON4D3/LuaSnip",
      after = "friendly-snippets"
    }
    use {
      "hrsh7th/nvim-cmp",
      after = "LuaSnip",
      config = function ()
        -- change name to avoid diagnostics
        require("user.plugins.cmpletion").setup()
      end,
    }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" } -- will delete
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
    use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }

    -- lsp
    use {
      "neovim/nvim-lspconfig",
      after = "nvim-cmp",
    }
    use {
      "williamboman/mason.nvim",
      after = "nvim-lspconfig",
    }
    use {
      "williamboman/mason-lspconfig.nvim",
      after = "mason.nvim",
      config = function ()
        require("user.lsp").setup()
      end,
    }

    -- telescope
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      event = { "CursorHold", "VimEnter" },
    }
    use {
      "nvim-telescope/telescope.nvim", branch = "0.1.x",
      requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
      after = "telescope-fzf-native.nvim",
      config = function ()
        require("user.plugins.telescope").setup()
      end
    }

    -- treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      -- Unknown error
      -- run = ":TSUpdate",
      config = function ()
        require("user.plugins.treesitter").setup()
      end
    }

    -- autopairs
    use {
      "windwp/nvim-autopairs",
      config = function ()
        require("user.plugins.autopairs").setup()
      end,
      after = "nvim-cmp",
    }

    -- which key
    use {
      "folke/which-key.nvim",
      config = function()
        require("user.plugins.which-key").setup()
      end,
      event = "CursorHold",
    }

    -- comment
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("user.plugins.comment").setup()
      end,
      event = "CursorHold",
    }
    use {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "CursorHold",
    }

    -- gitsigns
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("user.plugins.gitsigns").setup()
      end,
      -- event = "BufWinEnter",
      -- issue with starting page
      event = "CursorHold",
    }

    ---- indent_blankline
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function ()
        require("indent_blankline").setup {
          char = "▏",
          show_current_context_start = false
        }
      end,
      -- event = "BufWinEnter",
      -- issue with starting page
      event = "CursorHold"
    }

    use {
      "akinsho/toggleterm.nvim",
      tag = 'v2.*',
      config = function()
        require("user.plugins.toggleterm").setup()
      end,
      event = "CursorHold"
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end

    putils.sync_on_plugins_saved()
  end)
end

return M

