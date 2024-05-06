local dap = require('dap')
require('dap-go').setup()

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath('data') .. "mason/packages/chrome/out/src/chromeDebug.js" }
}

dap.configurations.javascript = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.configurations.javascriptreact = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.configurations.typescript = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.configurations.typescriptreact = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}


dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. "mason/packages/netcoredbg/netcoredbg",
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}

vim.keymap.set("n", "<leader>b", function() require('dap').toggle_breakpoint() end)
vim.keymap.set("n", "<F5>", function() require('dap').continue() end)
vim.keymap.set("n", "<F10>", function() require('dap').step_over() end)
vim.keymap.set("n", "<F11>", function() require('dap').step_into() end)
vim.keymap.set("n", "<F12>", function() require('dap').step_out() end)
