local M = {
  "windwp/nvim-autopairs",
  event = { "InsertEnter", "VeryLazy" },
}

function M.config()
  local npairs = require("nvim-autopairs")
  npairs.setup {
    check_ts = true,
    enable_check_bracket_line = false,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
  }

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {
    filetypes = {
      rust = false,
      cpp = false,
    }
  })
end

return M

