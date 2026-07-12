local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Insira os LSPs que você sempre quer disponíveis no seu Fedora
	ensure_installed = {
		'lua_ls',       -- Neovim/Lua
		'bashls',       -- Scripts de Shell
		'dockerls',     -- Dockerfile
		'docker_compose_language_service', -- Docker Compose
	},
	handlers = {
		function(server_name)
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			require('lspconfig')[server_name].setup({
				capabilities = capabilities
			})
		end,
	},
})
