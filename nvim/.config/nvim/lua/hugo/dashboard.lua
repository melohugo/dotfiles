local M = {}

local function set_highlights()
    local hls = {
        SnacksDashboardHeaderN  = { fg = "#ea6962", bold = true },
        SnacksDashboardHeaderE  = { fg = "#e78a4e", bold = true },
        SnacksDashboardHeaderO  = { fg = "#d8a657", bold = true },
        SnacksDashboardHeaderV  = { fg = "#a9b665", bold = true },
        SnacksDashboardHeaderI  = { fg = "#89b482", bold = true },
        SnacksDashboardHeaderM  = { fg = "#e7d7ad", bold = true },
        SnacksDashboardKey      = { fg = "#e78a4e" },
        SnacksDashboardIconFind = { fg = "#d8a657" },
        SnacksDashboardIconGit  = { fg = "#ea6962" },
        SnacksDashboardIconGrep = { fg = "#89b482" },
        SnacksDashboardIconRec  = { fg = "#d8a657" },
        SnacksDashboardIconExp  = { fg = "#e78a4e" },
        SnacksDashboardIconLazy = { fg = "#a9b665" },
        SnacksDashboardIconQuit = { fg = "#ea6962" },
    }
    for name, opts in pairs(hls) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

function M.get_opts()
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_highlights,
    })

    -- Garante que o ~ nunca apareça no buffer do dashboard
    pcall(function()
        local Snacks = require("snacks")
        Snacks.config.style("dashboard", {
            wo = {
                fillchars = "eob: ",
            },
        })
    end)

    -- Letras em ANSI Shadow com contornos 3D e espaçamento perfeito entre caracteres
    local letters_N = {
        '███╗   ██╗',
        '████╗  ██║',
        '██╔██╗ ██║',
        '██║╚██╗██║',
        '██║ ╚████║',
        '╚═╝  ╚═══╝',
    }
    local letters_E = {
        '███████╗',
        '██╔════╝',
        '█████╗  ',
        '██╔══╝  ',
        '███████╗',
        '╚══════╝',
    }
    local letters_O = {
        ' ██████╗ ',
        '██╔═══██╗',
        '██║   ██║',
        '██║   ██║',
        '╚██████╔╝',
        ' ╚═════╝ ',
    }
    local letters_V = {
        '██╗   ██╗',
        '██║   ██║',
        '██║   ██║',
        '╚██╗ ██╔╝',
        ' ╚████╔╝ ',
        '  ╚═══╝  ',
    }
    local letters_I = {
        '██╗',
        '██║',
        '██║',
        '██║',
        '██║',
        '╚═╝',
    }
    local letters_M = {
        '███╗   ███╗',
        '████╗ ████║',
        '██╔████╔██║',
        '██║╚██╔╝██║',
        '██║ ╚═╝ ██║',
        '╚═╝     ╚═╝',
    }

    local sections = {}

    for r = 1, 6 do
        table.insert(sections, {
            align = 'center',
            padding = (r == 6) and 2 or 0,
            text = {
                { letters_N[r], hl = 'SnacksDashboardHeaderN' },
                { ' ' },
                { letters_E[r], hl = 'SnacksDashboardHeaderE' },
                { ' ' },
                { letters_O[r], hl = 'SnacksDashboardHeaderO' },
                { ' ' },
                { letters_V[r], hl = 'SnacksDashboardHeaderV' },
                { ' ' },
                { letters_I[r], hl = 'SnacksDashboardHeaderI' },
                { ' ' },
                { letters_M[r], hl = 'SnacksDashboardHeaderM' },
            },
        })
    end

    -- Menu de teclas compacto e elegante
    table.insert(sections, {
        section = 'keys',
        gap = 0,
        padding = 1,
    })

    return {
        dashboard = {
            enabled = true,
            width = 40,
            formats = {
                icon = function(item)
                    return { item.icon, width = 2, hl = item.icon_hl or 'icon' }
                end,
                key = function(item)
                    return { '[' .. item.key .. ']', hl = item.key_hl or 'SnacksDashboardKey' }
                end,
            },
            preset = {
                keys = {
                    { icon = ' ', icon_hl = 'SnacksDashboardIconFind', key = 'f', desc = 'Buscar Arquivo', action = ':lua require("fzf-lua").files()' },
                    { icon = '󰊢 ', icon_hl = 'SnacksDashboardIconGit',  key = 'g', desc = 'Buscar Git', action = ':lua require("fzf-lua").git_files()' },
                    { icon = '󱎸 ', icon_hl = 'SnacksDashboardIconGrep', key = 's', desc = 'Live Grep', action = ':lua require("fzf-lua").live_grep()' },
                    { icon = ' ', icon_hl = 'SnacksDashboardIconRec',  key = 'r', desc = 'Arquivos Recentes', action = ':lua require("fzf-lua").oldfiles()' },
                    { icon = ' ', icon_hl = 'SnacksDashboardIconExp',  key = 'o', desc = 'Explorador de Arquivos', action = ':Oil' },
                    { icon = '󰏖 ', icon_hl = 'SnacksDashboardIconLazy', key = 'l', desc = 'Gerenciador de Plugins', action = ':Lazy' },
                    { icon = ' ', icon_hl = 'SnacksDashboardIconQuit', key = 'q', desc = 'Sair do Neovim', action = ':qa' },
                },
            },
            sections = sections,
        },
    }
end

return M
