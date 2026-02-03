local parsers = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "gowork",
  "lua",
  "luadoc",
  "make",
  "printf",
  "templ",
  "javascript",
  "css",
  "html",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

-- Install parsers (new API)
require("nvim-treesitter").install(parsers)

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
