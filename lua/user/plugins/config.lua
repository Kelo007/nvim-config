local function config_once()
  if not vim.g.loaded_user_config then
    -- require("user.settings").setup()
    require("user.options")
    require("user.keymaps")
    require("user.autocmds")
    require("user.ui").setup()
    -- TODO(Kelo): disable builtin plugins, see legacy settings.lua
    vim.g.loaded_user_config = true
  end
end

config_once()

return {}
