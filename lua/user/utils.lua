local M = {}

--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
  -- defer the function in case the autocommand is still in-use
  vim.schedule(function()
    pcall(function()
      vim.api.nvim_clear_autocmds { group = name }
    end)
  end)
end

function M.keymap(mode, key, map, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts and opts or {})
  vim.keymap.set(mode, key, map, opts)
end

function M.disable_builtin_plugins()
  local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
  }
  for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
  end
end

function M.open_logfile(filename)
  local cache_path = vim.call("stdpath", "cache")
  vim.cmd("edit " .. cache_path .. "/" .. filename)
end

M.icons = {
  kind = {
    Array = "",
    Boolean = "蘒",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Key = "",
    Keyword = "",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "ﳠ",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "",
    Reference = "",
    Snippet = "",
    String = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
  },
  git = {
    LineAdded = "",
    LineModified = "",
    LineRemoved = "",
    FileDeleted = "",
    FileIgnored = "◌",
    FileRenamed = "➜",
    FileStaged = "S",
    FileUnmerged = "",
    FileUnstaged = "",
    FileUntracked = "U",
    Diff = "",
    Repo = "",
    Octoface = "",
    Branch = "",
  },
  ui = {
    ArrowCircleDown = "",
    ArrowCircleLeft = "",
    ArrowCircleRight = "",
    ArrowCircleUp = "",
    BoldArrowDown = "",
    BoldArrowLeft = "",
    BoldArrowRight = "",
    BoldArrowUp = "",
    BoldClose = "",
    BoldDividerLeft = "",
    BoldDividerRight = "",
    BoldLineLeft = "▎",
    BookMark = "",
    BoxChecked = "",
    Bug = "",
    Stacks = " ",
    Scopes = "",
    Watches = "",
    DebugConsole = " ",
    Calendar = "",
    Check = "",
    ChevronRight = ">",
    ChevronShortDown = "",
    ChevronShortLeft = "",
    ChevronShortRight = "",
    ChevronShortUp = "",
    Circle = "",
    Close = "",
    CloudDownload = "",
    Code = "",
    Comment = "",
    Dashboard = "",
    DividerLeft = "",
    DividerRight = "",
    DoubleChevronRight = "»",
    Ellipsis = "…",
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = "",
    FileSymlink = "",
    Files = "",
    FindFile = "",
    FindText = "",
    Fire = "",
    Folder = "",
    FolderOpen = "",
    FolderSymlink = "",
    Forward = "",
    Gear = "",
    History = "",
    Lightbulb = "",
    LineLeft = "▏",
    LineMiddle = "│",
    List = "",
    Lock = "",
    NewFile = "",
    Note = "",
    Package = "",
    Pencil = "",
    Plus = "",
    Project = "",
    Search = "",
    SignIn = "",
    SignOut = "",
    Tab = "",
    Table = "",
    Target = "",
    Telescope = "",
    Text = "",
    Tree = "",
    Triangle = "契",
    TriangleShortArrowDown = "",
    TriangleShortArrowLeft = "",
    TriangleShortArrowRight = "",
    TriangleShortArrowUp = "",
  },
  diagnostics = {
    BoldError = "",
    Error = "",
    BoldWarning = "",
    Warning = "",
    BoldInformation = "",
    Information = "",
    BoldQuestion = "",
    Question = "",
    BoldHint = "",
    Hint = "",
    Debug = "",
    Trace = "✎",
  },
  misc = {
    Robot = "ﮧ",
    Squirrel = "",
    Tag = "",
    Watch = "",
    Smiley = "ﲃ",
    Package = "",
    CircuitBoard = "",
  },
}

return M

