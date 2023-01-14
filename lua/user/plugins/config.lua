local function config_once()
  if not vim.g.loaded_user_config then
    require("user.settings").setup()
    require("user.ui").setup()
    require("user.autocmds")
    vim.g.loaded_user_config = true
  end
end

config_once()

return {}
