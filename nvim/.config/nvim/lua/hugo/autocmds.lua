-- Automatically reload files when they change on disk
vim.opt.autoread = true

-- Check for file changes when focus is gained, buffer entered, or cursor is idle
-- Only run on normal, non-protocol buffers to prevent blank screen bugs
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
            local bufnr = vim.api.nvim_get_current_buf()
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if buftype == "" and bufname ~= "" and not bufname:match("^%w+://") then
                vim.cmd("checktime")
            end
        end
    end,
})

-- Refresh current oil buffer only when focus is gained
vim.api.nvim_create_autocmd("FocusGained", {
    pattern = "oil://*",
    callback = function(args)
        local buf = args.buf
        local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = buf })
        local ok2, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = buf })
        if ok and ok2 and ft == "oil" and not modified then
            pcall(function()
                require("oil").refresh()
            end)
        end
    end,
})

-- Notify when a file is automatically reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    pattern = "*",
    callback = function()
        vim.notify("Arquivo atualizado no disco. Buffer recarregado!", vim.log.levels.INFO, {
            title = "Neovim Autoreload",
        })
    end,
})



