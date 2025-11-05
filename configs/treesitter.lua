local options = {
    ensure_installed = {
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
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },
}

require("nvim-treesitter.configs").setup(options)
