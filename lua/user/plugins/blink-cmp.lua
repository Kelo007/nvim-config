local copilot = {
  enable = true,
}

copilot.next = function()
  if not copilot.enable then
    return false
  end
  local copilot_suggestion = require("copilot.suggestion")
  if copilot_suggestion.is_visible() then
    copilot_suggestion.next()
    return true
  end
  return false
end

copilot.prev = function()
  if not copilot.enable then
    return false
  end
  local copilot_suggestion = require("copilot.suggestion")
  if copilot_suggestion.is_visible() then
    copilot_suggestion.prev()
    return true
  end
  return false
end

copilot.accept = function()
  if not copilot.enable then
    return false
  end
  local copilot_suggestion = require("copilot.suggestion")
  if copilot_suggestion.is_visible() then
    copilot_suggestion.accept()
    return true
  end
  return false
end

local M = {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "zbirenbaum/copilot.lua",
  },
  version = "*",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-j>"] = { "select_next", copilot.next, "fallback" },
      ["<C-k>"] = { "select_prev", copilot.prev, "fallback" },
      ["<C-e>"] = { "hide", copilot.accept, "fallback" },
      ["<C-l>"] = { "snippet_forward" },
      ["<C-h>"] = { "snippet_backward" },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = { min_width = 20 },
    },
    signature = { enabled = true },
  },
}

return M
