local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- { "nvim-treesitter/playground" },
  },
  build = ":TSUpdate",
  event = { "BufReadPost", "VeryLazy" },
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {},
    sync_install = false,
    auto_install = false,
    ignore_install = {},
    highlight = {
      enable = true,
      -- disable treesitter for large file
      disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "yaml", "python" } },
    autopairs = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = "// %s",
        css = "/* %s */",
        scss = "/* %s */",
        html = "<!-- %s -->",
        svelte = "<!-- %s -->",
        vue = "<!-- %s -->",
        json = "",
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "v",
        node_decremental = "V",
      },
    },
    playground = {
      enable = false,
    }
  }
end

return M
