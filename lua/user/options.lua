local opt = vim.opt

opt.list = true
-- listchars="tab: »,nbsp:␣,trail:·,extends:›,precedes:‹",
-- listchars = "tab:⎸→,nbsp:␣,trail:·",
-- listchars = "tab:▏―,nbsp:␣,trail:·",
opt.listchars = "tab:▏┄,nbsp:␣,trail:·"
opt.lazyredraw = true
opt.fileencodings = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936"
opt.ignorecase = true
opt.mouse = "a"
opt.pumheight = 10
opt.showtabline = 2
opt.smartcase = true
-- opt.smartindent = true
opt.smarttab = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.termguicolors = true
opt.timeoutlen = 1000
opt.title = true
opt.titlestring = "%t %m (%.30F) - NVIM"
opt.updatetime = 300
opt.writebackup = false
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.laststatus = 3
opt.shortmess:append("I")
-- TODO(Kelo): format options
-- opt.formatexpr = ""
-- opt.formatoptions = "tcqj"
opt.showmode = false
opt.ruler = false
opt.virtualedit = "block"
-- TODO(Kelo): fold options
opt.foldlevel = 99
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",

  -- make separator thicker
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
-- wsl clipboard
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
