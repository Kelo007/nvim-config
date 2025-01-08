local M = {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup {
      windowCreationCommand = "70vsplit",
      keymaps = {
        replace = { n = "<C-r>" },
        qflist = { n = "<C-q>" },
        syncLocations = { n = "<C-s>" },
        syncLine = { n = "<C-l>" },
        close = { n = "<C-c>" },
        historyOpen = { n = "<C-t>" },
        historyAdd = { n = "<C-a>" },
        refresh = { n = "<C-f>" },
        openLocation = { n = "<C-o>" },
        openNextLocation = { n = "<down>" },
        openPrevLocation = { n = "<up>" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
        abort = { n = "<C-b>" },
        help = { n = "g?" },
        toggleShowCommand = { n = "<C-p>" },
        swapEngine = { n = "<C-e>" },
        previewLocation = nil,
        swapReplacementInterpreter = { n = "<C-x>" },
        applyNext = { n = "<C-j>" },
        applyPrev = { n = "<C-k>" },
      }

    }
  end,
  keys = {
    { "<leader>ss", "<cmd>GrugFar<cr>", desc = "Search and replace" },
  }
}

return M
