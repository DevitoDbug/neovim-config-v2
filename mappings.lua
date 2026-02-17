require "nvchad.mappings"

-- add yours here
-- Cheat sheet (use the command :help key-notation to see all key reps)
-- <cmd> means :
-- <CR> means "ENTER" key

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- which-key hints for surround
vim.defer_fn(function()
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.add {
      { "ys", group = "Surround" },
      { "ds", group = "Delete surround" },
      { "cs", group = "Change surround" },
    }
  end
end, 100)

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })

-- Auto-save all buffers after LSP rename
local orig_rename_handler = vim.lsp.handlers["textDocument/rename"]
vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
  local ret = orig_rename_handler(err, result, ctx, config)
  if not err and result then
    vim.cmd "wa"
  end
  return ret
end

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

-- Laravel: gf to navigate views, includes, extends, and components
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "blade" },
  callback = function(args)
    vim.keymap.set("n", "gf", function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]

      -- Find the string under/near cursor
      local str = nil
      for s, content, e in line:gmatch '()["\'](.-)["\']()' do
        if col >= s - 1 and col < e then
          str = content
          break
        end
      end

      if not str then
        -- Fallback to default gf
        vim.cmd "normal! gf"
        return
      end

      -- Convert dot notation to path
      local view_path = "resources/views/" .. str:gsub("%.", "/") .. ".blade.php"
      if vim.fn.filereadable(view_path) == 1 then
        vim.cmd("edit " .. view_path)
        return
      end

      -- Try as component (x-component-name -> components/component-name.blade.php)
      local component_path = "resources/views/components/" .. str:gsub("%.", "/") .. ".blade.php"
      if vim.fn.filereadable(component_path) == 1 then
        vim.cmd("edit " .. component_path)
        return
      end

      -- Fallback to default gf
      vim.cmd "normal! gf"
    end, { buffer = args.buf, desc = "Laravel: Go to view file" })
  end,
})
