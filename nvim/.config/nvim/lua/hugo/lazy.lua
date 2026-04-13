local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- FZF-Lua (Substituindo Telescope por performance e estabilidade)
    { 
        "ibhagwan/fzf-lua",
        -- dependências opcionais para ícones
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("fzf-lua").setup({})
        end
    },

    -- Cores
    { "sainnhe/gruvbox-material", priority = 1000 },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- UI Moderna
    {
        'folke/noice.nvim',
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
        }
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    -- Utilidades
    'nvim-lua/plenary.nvim',
    'ThePrimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'christoomey/vim-tmux-navigator',
    'eandrju/cellular-automaton.nvim',
    'ThePrimeagen/vim-with-me',
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- LSP & Autocomplete (Moderno)
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'L3MON4D3/LuaSnip'},
        }
    },
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },
})
