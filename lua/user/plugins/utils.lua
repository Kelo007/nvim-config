local M = {}

function M.ensure_packer_installed()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

function M.sync_on_plugins_saved()
  -- Autocommand that reloads neovim whenever you save the plugins.lua file
  vim.api.nvim_create_augroup("packer_user_config", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    callback = function ()
      package.loaded["user.plugins"] = nil
      require("user.plugins").setup()
      require('packer').sync()
    end
  })

  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua  lua require("user.plugins").setup() | PackerSync
    augroup end
  ]])
end

return M
