require("nvchad.mappings")

-- add yours here
-- Cheat sheet (use the command :help key-notation to see all key reps)
-- <cmd> means :
-- <CR> means "ENTER" key

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })

-- Resize vertical splits
map("n", "<C-Left>", "<cmd> vertical resize -5 <CR>", { desc = "Decrease split width" })
map("n", "<C-Right>", "<cmd> vertical resize +5 <CR>", { desc = "Inrease split width" })

-- Moving lines and blocks up and down
map("n", "<C-Up>", "<cmd>m .-2<CR>==", opts)
map("n", "<C-Down>", "<cmd>m .+1<CR>==", opts)

map("i", "<C-Up>", "<Esc><cmd>m .-2<CR>==gi", opts)
map("i", "<C-Down>", "<Esc><cmd>m .+1<CR>==gi", opts)

map("v", "<C-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<C-Down>", ":m '>+1<CR>gv=gv", opts)
