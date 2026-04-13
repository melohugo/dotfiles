local fzf = require('fzf-lua')

fzf.setup({
    -- Forçando o visual do Telescope
    winopts = {
        height = 0.85,
        width  = 0.80,
        preview = {
            layout = 'horizontal', -- FORÇA horizontal, não deixa ficar vertical
            horizontal = 'right:50%',
        },
    },
    -- Estilo de busca do fzf (lista de cima para baixo)
    fzf_opts = {
        ['--layout'] = 'reverse',
    },
})

-- Atalhos de teclado
vim.keymap.set('n', '<leader>pf', fzf.files, { desc = "Fzf Arquivos" })
vim.keymap.set('n', '<C-f>', fzf.git_files, { desc = "Fzf Git Files" })
vim.keymap.set('n', '<leader>ps', fzf.live_grep, { desc = "Fzf Live Grep" })
vim.keymap.set('n', '<leader>pw', fzf.grep_cword, { desc = "Fzf Word under cursor" })
vim.keymap.set('n', '<leader>pb', fzf.buffers, { desc = "Fzf Buffers" })
vim.keymap.set('n', '<leader>vh', fzf.help_tags, { desc = "Fzf Help" })

-- Integração LSP
vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = "LSP References" })
vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = "LSP Definitions" })
vim.keymap.set('n', '<leader>pd', fzf.diagnostics_document, { desc = "LSP Diagnostics" })
