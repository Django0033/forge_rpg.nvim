local M = {}

M.version = "1.0.0"

function M.setup(opts)
  opts = opts or {}

  math.randomseed(os.time())

  require("forge-nvim.commands").setup()
end

return M
