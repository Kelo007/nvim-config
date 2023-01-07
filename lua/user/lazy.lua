local M = {}

function M.setup()
  -- ensure lazy.nvim is installed
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable", -- remove this if you want to bootstrap to HEAD
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup("user.plugins", {
    defaults = { lazy = true },
    change_detection = {
      notify = false,
    },
    ui = { border = "rounded" },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  })

  -- TODO: add a keymap to open the log of lazy.nvim
end

return M
