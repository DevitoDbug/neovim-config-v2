local lint = require "lint"

lint.linters_by_ft = {
  lua = { "luacheck" },
  python = { "flake8" },
  go = { "golangcilint" },
}

lint.linters.flake8.args = {
  "--max-line-length",
  "100",
  "--stdin-display-name",
  function()
    return vim.api.nvim_buf_get_name(0)
  end,
  "-",
}

lint.linters.luacheck.args = {
  -- unpack(lint.linters.luacheck.args),
  "--globals",
  "love",
  "vim",
  "--formatter",
  "plain",
  "--codes",
  "--ranges",
  "-",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
