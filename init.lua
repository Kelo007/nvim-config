--require("impatient").enable_profile()
pcall(require, "impatient")

require("user.settings").setup()
require("user.plugins").setup()
require("user.ui").setup()

