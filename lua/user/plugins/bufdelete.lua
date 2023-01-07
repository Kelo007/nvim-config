local filetype_close = { "NvimTree", "help", "TelescopePrompt" }

local function quit()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  for _, v in pairs(filetype_close) do
    if filetype == v then
      vim.api.nvim_win_close(0, true)
      return
    end
  end
  local force = vim.api.nvim_buf_get_option(0, "buftype") == "terminal"
  require("bufdelete").bufdelete(0, force)
end

return {
  "famiu/bufdelete.nvim",
  keys = {
    { "<leader>q", quit, desc = "Close Buffer" }
  },
  cmd = { "Bdelete", "Bwipeout" }
}
