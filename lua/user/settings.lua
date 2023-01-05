local M = {}

function M.setup()
  local options = {
    fileformats = "unix,mac,dos",
    list = true,
    -- listchars="tab: »,nbsp:␣,trail:·,extends:›,precedes:‹",
    -- listchars = "tab:⎸→,nbsp:␣,trail:·",
    -- listchars = "tab:▏―,nbsp:␣,trail:·",
    listchars = "tab:▏┄,nbsp:␣,trail:·",
    backup = false, -- creates a backup file
    -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    lazyredraw = true,
    -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    -- can not change in unmodifyable mode
    -- fileencoding = "utf-8", -- the encoding written to a file
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = true, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    -- smartindent = true, -- make indenting smarter again
    smarttab = true,
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true,
    titlestring = "%t %m (%.30F) - NVIM",
    undofile = false, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    scrolloff = 4, -- is one of my fav
    sidescrolloff = 8,
    laststatus = 3,
  }

  local append_opts = {
    shortmess = "I" -- do not show intro page, some plugins opened by CursorHold event will close intro page
  }

  local disable_builtin_plugins = true

  local autocmds = {
    -- do not insert comment when press o
    [[
      augroup Format-Options
        autocmd!
        autocmd BufEnter * setlocal formatoptions-=o
        " autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
        " This can be done as well instead of the previous line, for setting formatoptions as you choose:
        " autocmd BufEnter * setlocal formatoptions=crqn2l1j
      augroup END
    ]],
  }

  local keymap_opts = { noremap = true, silent = true }

  local keymaps = {
    { "n", "<C-h>", "<C-w>h" },
    { "n", "<C-j>", "<C-w>j" },
    { "n", "<C-k>", "<C-w>k" },
    { "n", "<C-l>", "<C-w>l" },
    { "n", "<space>", "<nop>" },

    { "n", "<S-h>", "<Home>" },
    { "n", "<S-l>", "<End>" },
    { "x", "<S-h>", "<Home>" },
    { "x", "<S-l>", "<End>" },

    { "n", "<A-j>", ":move .+1<cr>==" },
    { "n", "<A-k>", ":move .-2<cr>==" },
    { "v", "<A-j>", ":move '>+1<cr>gv=gv" },
    { "v", "<A-k>", ":move '<-2<cr>gv=gv" },

    { "n", "ZA", ":confirm qall<cr>" },

    -- yank
    { "n", "Y", "\"+y" },
    { "v", "Y", "\"+y" },

    { "n", "<up>", ":resize +5<cr>" },
    { "n", "<down>", ":resize -5<cr>" },
    { "n", "<right>", ":vertical resize +5<cr>" },
    { "n", "<left>", ":vertical resize -5<cr>" },

    { "n", "Q:", "q:" },
    { "n", "Q/", "q/" },
    { "n", "Q?", "q?" },
    { "n", "q:", "<nop>" },
    { "n", "q/", "<nop>" },
    { "n", "q?", "<nop>" },

    --  {"n", "H", "7h"},
    --  {"n", "J", "5j"},
    --  {"n", "K", "5k"},
    --  {"n", "L", "7l"},
    --  {"v", "H", "7h"},
    --  {"v", "J", "5j"},
    --  {"v", "K", "5k"},
    --  {"v", "L", "7l"},

    { "n", "VV", "ggVG" },

    { "v", "<", "<gv" },
    { "v", ">", ">gv" },

    { "i", "jj", "<esc>" },
    --{"i", "jk", "<esc>"},
    --{"i", "kj", "<esc>"},

    --{"n", "<leader>s", ":luafile $MYVIMRC<cr>:nohls<cr>"},
    { "n", "<leader>w", ":write<cr>", { desc = "Save" } },
    { "n", "<leader>q", ":quit<cr>", { desc = "Close Buffer" } },
    { "n", "<leader>c", ":close<cr>", { desc = "Close Window" } },
    { "n", "<leader>h", ":nohls<cr>", { desc = "No Highlight" } },
    { "n", "<leader>e", ":Lex 30<cr>", { desc = "Toggle Explorer" } },

    { "n", "<leader>Ln", ":edit $NVIM_LOG_FILE<cr>", { desc = "Neovim Logfile" } },

    -- { "c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    -- { "c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    { "c", "<C-j>", "<C-n>" },
    { "c", "<C-k>", "<C-p>" },

    -- terminal keymap
    { "t", "<esc>", [[<C-\><C-n>]] },
    { "t", "<C-h>", [[<C-\><C-n><C-w>h]] },
    { "t", "<C-j>", [[<C-\><C-n><C-w>j]] },
    { "t", "<C-k>", [[<C-\><C-n><C-w>k]] },
    { "t", "<C-l>", [[<C-\><C-n><C-w>l]] },
  }

  local utils = require("user.utils")

  for k, v in pairs(options) do
    vim.opt[k] = v
  end
  for k, v in pairs(append_opts) do
    vim.opt[k]:append(v)
  end

  if disable_builtin_plugins then
    utils.disable_builtin_plugins()
  end

  for _, cmd in pairs(autocmds) do
    vim.cmd(cmd)
  end

  for _, v in ipairs(keymaps) do
    utils.keymap(v[1], v[2], v[3], v[4] and v[4] or keymap_opts)
  end
end

return M
