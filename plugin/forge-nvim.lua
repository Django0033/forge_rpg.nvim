if vim.g.loaded_forge_nvim then
  return
end
vim.g.loaded_forge_nvim = 1

require('forge-nvim').setup()
