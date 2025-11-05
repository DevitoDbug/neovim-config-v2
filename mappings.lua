require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })

-- Resize vertical splits
map("n", "<C-Left>", "<cmd> vertical resize -5 <CR>", { desc = "Decrease split width" })
map("n", "<C-Right>", "<cmd> vertical resize +5 <CR>", { desc = "Inrease split width" })
