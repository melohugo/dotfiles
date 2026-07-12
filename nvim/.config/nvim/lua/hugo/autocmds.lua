-- Automatically reload files when they change on disk
vim.opt.autoread = true

-- Check for file changes when focus is gained, buffer entered, or cursor is idle
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
        if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

-- Double insurance: refresh current oil buffer only when focus is gained
vim.api.nvim_create_autocmd("FocusGained", {
    pattern = "oil://*",
    callback = function(args)
        local buf = args.buf
        local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = buf })
        local ok2, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = buf })
        if ok and ok2 and ft == "oil" and not modified then
            pcall(function()
                vim.cmd("edit!")
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

-- Watch oil.nvim directories and automatically refresh them when files change
local oil_watchers = {}
local refresh_timers = {}

local function cleanup_timer(buf)
    if refresh_timers[buf] then
        pcall(function() refresh_timers[buf]:stop() end)
        pcall(function() refresh_timers[buf]:close() end)
        refresh_timers[buf] = nil
    end
end

local function cleanup_watcher(buf)
    if oil_watchers[buf] then
        pcall(function() oil_watchers[buf]:stop() end)
        oil_watchers[buf] = nil
    end
    cleanup_timer(buf)
end

local function debounced_refresh(buf)
    cleanup_timer(buf)

    -- Use vim.uv (Neovim 0.10+) or fall back to vim.loop
    local uv = vim.uv or vim.loop
    if not uv then return end

    local timer = uv.new_timer()
    if not timer then return end
    refresh_timers[buf] = timer

    -- Debounce for 100ms to group multiple rapid events together
    timer:start(100, 0, vim.schedule_wrap(function()
        cleanup_timer(buf)
        -- Only refresh if the target buffer is still valid and is the current active buffer
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_current_buf() == buf then
            local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = buf })
            local ok2, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = buf })
            if ok and ok2 and ft == "oil" and not modified then
                pcall(function()
                    vim.cmd("edit!")
                end)
            end
        end
    end))
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "oil://*",
    callback = function(args)
        local buf = args.buf
        if oil_watchers[buf] then return end

        -- Defer initialization slightly to ensure oil has populated directory info
        vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(buf) then return end
            if oil_watchers[buf] then return end

            local oil = require("oil")
            local dir = oil.get_current_dir(buf)
            if not dir then
                -- Fallback: extract path from oil:// buffer name
                local bufname = vim.api.nvim_buf_get_name(buf)
                dir = bufname:match("^oil://(.*)")
            end
            if not dir then return end

            -- Use vim.uv (Neovim 0.10+) or fall back to vim.loop
            local uv = vim.uv or vim.loop
            if not uv then return end

            local w = uv.new_fs_event()
            if not w then return end

            oil_watchers[buf] = w
            
            -- Start watching the directory. Wrap in pcall in case the directory is not watchable.
            pcall(function()
                w:start(dir, {}, vim.schedule_wrap(function(err, filename, events)
                    if err then return end
                    debounced_refresh(buf)
                end))
            end)
        end, 50)
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufDelete", "BufWipeout" }, {
    pattern = "oil://*",
    callback = function(args)
        cleanup_watcher(args.buf)
    end,
})


