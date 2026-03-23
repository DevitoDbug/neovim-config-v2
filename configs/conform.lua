local options = {
  formatters_by_ft = {
    go = { "gofumpt" },
    c_pp = { "clang-format" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    lua = { "stylua" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    bash = { "shfmt" },
    templ = { "templ" },
    blade = { "blade-formatter" },
  },
  formatters = {
    clang_format = {
      prepend_args = {
        "-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true, \
                PackConstructorInitializers: Never}",
      },
    },
    black = {
      prepend_args = {
        "--fast",
        "--line-length",
        "100",
      },
    },
    isort = {
      prepend_args = {
        "--profile",
        "black",
      },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
