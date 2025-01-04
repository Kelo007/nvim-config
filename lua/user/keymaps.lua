local map = require("user.utils").keymap
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<space>", "<nop>")

map({"n", "x", "o"}, "<S-h>", "<Home>")
map({"n", "x", "o"}, "<S-l>", "<End>")

map("n", "gL", "`\"", { desc = "Go to last exited current buffer line" })

map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- comment
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
map({ "n", "x" }, "<leader>/", "<cmd>normal gcc<cr>", { desc = "Toggle Comment" })

map("n", "ZA", ":confirm qall<cr>")

-- yank
map("n", "YY", "\"+yy")
map("v", "Y", "\"+y")
map("i", "<C-v>", "<C-r>+")

map("n", "<C-up>", ":resize +5<cr>")
map("n", "<C-down>", ":resize -5<cr>")
map("n", "<C-right>", ":vertical resize +5<cr>")
map("n", "<C-left>", ":vertical resize -5<cr>")

map("n", "Q:", "q:")
map("n", "Q/", "q/")
map("n", "Q?", "q?")
map("n", "q:", "<nop>")
map("n", "q/", "<nop>")
map("n", "q?", "<nop>")

-- map("n", "H", "7h")
-- map("n", "J", "5j")
-- map("n", "K", "5k")
-- map("n", "L", "7l")
-- map("v", "H", "7h")
-- map("v", "J", "5j")
-- map("v", "K", "5k")
-- map("v", "L", "7l")

map("n", "VV", "ggVG")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("i", "jj", "<esc>")

map({ "i", "c" }, "<C-a>", "<Home>", { silent = false })
-- there has already been a mapping for <C-e> in command mode
map({ "i" }, "<C-e>", "<End>", { silent = false })
map({ "i", "c" }, "<C-b>", "<Left>", { silent = false })
map({ "i", "c" }, "<C-f>", "<Right>", { silent = false })
map({ "i", "c" }, "<C-d>", "<Del>", { silent = false })
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

map("n", "<leader>w", ":write<cr>", { desc = "Save" })
map("n", "<leader>q", ":quit<cr>", { desc = "Close Buffer" })
map("n", "<leader>c", ":close<cr>", { desc = "Close Window" })
map("n", "<leader>h", function()
  if vim.v.hlsearch == 1 then
    vim.cmd("nohlsearch")
  else
    local cword = vim.fn.expand("<cword>")
    if cword == nil or #cword == 0 then
      return
    end
    vim.fn.setreg("/", "\\<" .. cword .. "\\>")
    vim.o.hlsearch = true
  end
end, { desc = "Highlight" })
map("n", "<leader>e", ":Lex 30<cr>", { desc = "Toggle Explorer" })

map("n", "<leader>Ln", ":edit $NVIM_LOG_FILE<cr>", { desc = "Neovim Logfile" })

-- { "c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
-- { "c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
map("c", "<C-j>", "<C-n>")
map("c", "<C-k>", "<C-p>")

-- terminal keymap
map("t", "<esc>", [[<C-\><C-n>]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])
