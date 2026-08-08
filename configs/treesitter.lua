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
  "typescript",
  "tsx",
  "css",
  "html",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
  "php",
}

-- Install parsers (new API)
require("nvim-treesitter").install(parsers)

vim.filetype.add {
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
}

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
