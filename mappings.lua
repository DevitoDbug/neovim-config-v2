require "nvchad.mappings"

-- add yours here
-- Cheat sheet (use the command :help key-notation to see all key reps)
-- <cmd> means :
-- <CR> means "ENTER" key

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })

-- Resize vertical and horizontal splits
map("n", "<C-Left>", "<cmd> vertical resize -5 <CR>", { desc = "Decrease split width" })
map("n", "<C-Right>", "<cmd> vertical resize +5 <CR>", { desc = "Increase split width" })
map("n", "<C-Up>", "<cmd> resize +5 <CR>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd> resize -5 <CR>", { desc = "Decrease height" })

-- Moving lines and blocks up and down
map("i", "<C-Up>", "<Esc><cmd>m .-2<CR>==gi", opts)
map("i", "<C-Down>", "<Esc><cmd>m .+1<CR>==gi", opts)

map("v", "<C-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<C-Down>", ":m '>+1<CR>gv=gv", opts)

-- DAP (Debug) keybindings
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Start/Continue debugging" })
map("n", "<leader>ds", "<cmd>DapStepOver<CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>DapStepOut<CR>", { desc = "Step out" })
map("n", "<leader>dt", "<cmd>DapTerminate<CR>", { desc = "Terminate debugging" })
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle debug UI" })
