require "nvchad.options"

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Indentation
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

-- Other shit
o.relativenumber = true
o.spell = true
o.winborder = "rounded"

-- Folds
local ts_fold = vim.fn.exists ":TSFoldEnable" == 1

if ts_fold then
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
else
  vim.o.foldmethod = "indent"
end
o.foldenable = true
o.foldlevel = 99
