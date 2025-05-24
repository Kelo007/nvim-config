vim.g.mapleader = " "
vim.g.maplocalleader = " "

if not vim.g.vscode then
  require("user.lazy").setup()
else
  require("vscode-nvim.lazy").setup()
end
