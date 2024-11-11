local M = {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  lazy = false,
  version = "v0.*",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
    },
    nerd_font_variant = "mono",

    accept = { auto_brackets = { enabled = true } },
    trigger = { signature_help = { enabled = true } },
  },
  opts_extend = { "sources.completion.enabled_providers" },
  window = {
    autocomplete = {
      min_width = 20,
    }
  }
}

return M
