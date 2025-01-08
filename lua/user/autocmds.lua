local function augroup(name)
  return vim.api.nvim_create_augroup("user_augroup_" .. name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("go_to_last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close special buffers with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lspinfo", "lsp-installer", "null-ls-info", "help", "qf", "man", "checkhealth" },
  group = augroup("close_buffers"),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    local opts = { buffer = event.buf, silent = true, nowait = true, desc = "quit special buffer" }
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd.close()
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, opts)
    end)
  end,
  desc = "close lspinfo popup and help,qf buffers with q",
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_on_yank"),
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search", timeout = 250
    }
  end,
  desc = "highlight on yank",
})

-- do not insert comments when press o
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("do_not_insert_comments_when_press_o"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove "o"
  end,
  desc = "do not insert comments when press o",
})

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
  desc = "check if we need to reload the file when it changed",
})
