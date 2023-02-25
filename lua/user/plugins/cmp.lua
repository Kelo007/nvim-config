local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip",
    "Kelo007/copilot.lua",
  },
  event = { "VeryLazy", "InsertEnter" }
}

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local copilot_suggestion = require("copilot.suggestion")

  -- see issue: https://www.reddit.com/r/neovim/comments/yiimig/cmp_luasnip_jump_points_strange_behaviour/
  luasnip.config.set_config({
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave'
  })

  require("luasnip/loaders/from_vscode").lazy_load()

  local max_width = 50
  local kind_icons = require("user.utils").icons.kind

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = 'menu,menuone,noinsert'
    },
    mapping = {
      ["<C-k>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
          elseif copilot_suggestion.is_visible() then
            copilot_suggestion.prev()
          else
            fallback()
          end
        end,
        c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      },
      ["<C-j>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          elseif copilot_suggestion.is_visible() then
            copilot_suggestion.next()
          else
            fallback()
          end
        end,
        c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      },
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),
      ["<C-t>"] = cmp.mapping {
        i = cmp.mapping.complete(),
        c = function(fallback)
          if not cmp.visible() then
            local tab_key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
            vim.api.nvim_feedkeys(tab_key, "t", true)
          else
            fallback()
          end
        end,
      },
      ["<C-c>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.abort()
          elseif copilot_suggestion.is_visible() then
            copilot_suggestion.dismiss()
          else
            fallback()
          end
        end,
        c = function(fallback)
          if cmp.visible() then
            -- see help c_CTRL-E
            local end_key = vim.api.nvim_replace_termcodes("<C-e>", true, false, true)
            vim.api.nvim_feedkeys(end_key, "n", true)
          else
            fallback()
          end
        end
      },
      ["<C-e>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          elseif copilot_suggestion.is_visible() then
            copilot_suggestion.accept()
          else
            fallback()
          end
        end,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { select = true }
        -- elseif luasnip.expand_or_locally_jumpable() then
        --   luasnip.expand_or_jump()
        -- elseif check_backspace() then
        --   fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          -- luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-;>"] = cmp.mapping(function(_)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          -- do not insert words "<C-;>"
          -- fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-,>"] = cmp.mapping(function(_)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          -- do not insert words "<C-,>"
          -- fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<bs>"] = cmp.mapping(function(_)
        local keys = vim.api.nvim_replace_termcodes("<C-o>c", true, false, true)
        vim.api.nvim_feedkeys(keys, "n", false)
        vim.schedule(function()
          cmp.complete {
            config = {
              sources = { { name = "nvim_lsp_signature_help" } }
            }
          }
        end)
      end, { "s" }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if max_width ~= 0 and #vim_item.abbr > max_width then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
        end
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lsp_signature_help = "[LSP_SH]",
          nvim_lua = "[NVIM_LUA]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
      -- native_menu = true,
    },
  }
end

return M
