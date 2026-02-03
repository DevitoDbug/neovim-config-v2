local dap = require "dap"

-- codelldb adapter configuration
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

-- C configuration
dap.configurations.c = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- C++ uses same config as C
dap.configurations.cpp = dap.configurations.c

-- Rust configuration
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Try to find the binary in target/debug
      local cwd = vim.fn.getcwd()
      local cargo_toml = io.open(cwd .. "/Cargo.toml", "r")
      if cargo_toml then
        cargo_toml:close()
        -- Get project name from directory
        local project_name = vim.fn.fnamemodify(cwd, ":t")
        local default_path = cwd .. "/target/debug/" .. project_name
        return vim.fn.input("Path to executable: ", default_path, "file")
      end
      return vim.fn.input("Path to executable: ", cwd .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
