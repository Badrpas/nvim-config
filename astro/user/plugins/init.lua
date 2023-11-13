-- require('user.plugins.rust-tools')

return {
	{ "justinmk/vim-sneak",       event = "BufEnter" },
	{ "mg979/vim-visual-multi",   event = "BufEnter" },
	{ "othree/html5.vim",         ft = "html" },
	{ "pangloss/vim-javascript" },
	{ "evanleck/vim-svelte",      event = "BufEnter" },
	{ "simrat39/rust-tools.nvim", ft = "rs" },

	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			-- include the default astronvim config that calls the setup call
			local config = require("user.luasnip")
			require("plugins.configs.luasnip")(plugin, config)
			-- load snippets paths
			require("luasnip").add_snippets("typescript", require("user.snippets.typescript"))
			require("luasnip").add_snippets("rust", require("user.snippets.rust"))
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			handlers = {
				-- eslint = function ()
				-- 	local nls = require("null-ls")
				-- 	local b = require("null-ls").builtins
				-- 	local h = require("null-ls.helpers")
				-- 	nls.register(b.formatting.eslint.with({
				-- 		condition = function (utils)
				-- 			print("top kek")
				-- 			return true
				-- 		end
				-- 	}))
				-- end,

				-- eslint_d = function()
				-- 	local nls = require("null-ls")
				-- 	local b = require("null-ls").builtins
				-- 	local h = require("null-ls.helpers")
				-- 	local cmd_resolver = require("null-ls.helpers.command_resolver")
				-- 	local methods = require("null-ls.methods")
				-- 	local u = require("null-ls.utils")
				--
				-- 	-- nls.register(b.formatting.eslint.with({
				-- 	-- 	generator_opts = {
				-- 	-- 		command = "eslint",
				-- 	-- 		args = { "--fix-dry-run", "--format", "json", "--stdin", "--stdin-filename", "$FILENAME" },
				-- 	-- 		to_stdin = true,
				-- 	-- 		format = "json",
				-- 	-- 		on_output = function(params)
				-- 	-- 			local parsed = params.output[1]
				-- 	-- 			return parsed
				-- 	-- 				and parsed.output
				-- 	-- 				and {
				-- 	-- 					{
				-- 	-- 						row = 1,
				-- 	-- 						col = 1,
				-- 	-- 						end_row = #vim.split(parsed.output, "\n") + 1,
				-- 	-- 						end_col = 1,
				-- 	-- 						text = parsed.output,
				-- 	-- 					},
				-- 	-- 				}
				-- 	-- 		end,
				-- 	-- 		dynamic_command = cmd_resolver.from_node_modules(),
				-- 	-- 		check_exit_code = { 0, 1 },
				-- 	-- 		cwd = h.cache.by_bufnr(function(params)
				-- 	-- 			print('cwd params', vim.inspect(params))
				-- 	-- 			return u.root_pattern(
				-- 	-- 			-- https://eslint.org/docs/latest/user-guide/configuring/configuration-files-new
				-- 	-- 				"eslint.config.js",
				-- 	-- 				-- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
				-- 	-- 				".eslintrc",
				-- 	-- 				".eslintrc.js",
				-- 	-- 				".eslintrc.cjs",
				-- 	-- 				".eslintrc.yaml",
				-- 	-- 				".eslintrc.yml",
				-- 	-- 				".eslintrc.json",
				-- 	-- 				"package.json"
				-- 	-- 			)(params.bufname)
				-- 	-- 		end),
				-- 	-- 	},
				-- 	-- }))
				-- end,

				-- eslint_d = function()
				-- 	local nls = require("null-ls")
				-- 	local b = require("null-ls").builtins
				--
				-- 	local eslint_root_dir = require('null-ls.utils').root_pattern('.eslintrc.json', '.eslintrc.js')
				-- 	local condition = function(utils)
				-- 		-- local result = utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js")
				-- 		local result = eslint_root_dir(vim.api.nvim_buf_get_name(0))
				-- 		print('cond', result)
				-- 		return result
				-- 	end
				--
				--
				-- 	nls.register(b.code_actions.eslint_d.with({
				-- 		condition = condition,
				-- 	}))
				-- 	nls.register(b.diagnostics.eslint_d.with({
				-- 		condition = condition,
				-- 	}))
				-- 	nls.register(b.formatting.eslint_d.with({
				-- 		condition = condition,
				-- 	}))
				-- 	print('inited eslint_d')
				--
				-- 	local inv_condition = function(utils)
				-- 		return not condition(utils)
				-- 	end
				-- 	-- nls.register(b.code_actions.eslint_d.with({
				-- 	-- 	condition = inv_condition,
				-- 	-- 	generator_opts = {
				-- 	-- 		command = "eslint_d",
				-- 	-- 		args = {"--config=~/.eslintrc.js"},
				-- 	-- 	}
				-- 	-- }));
				-- 	-- nls.register(b.diagnostics.eslint_d.with({
				-- 	-- 	condition = inv_condition,
				-- 	-- 	-- generator_opts = {
				-- 	-- 		command = "eslint_d",
				-- 	-- 		args = {"--config", "~/.eslintrc.json"},
				-- 	-- 	-- }
				-- 	-- }));
				-- 	-- nls.register(b.formatting.eslint_d.with({
				-- 	-- 	condition = inv_condition,
				-- 	-- 	generator_opts = {
				-- 	-- 		command = "eslint_d",
				-- 	-- 		args = { "--fix-to-stdout", "--config", "~/.eslintrc.json", "--stdin", "--stdin-filename", "$FILENAME" },
				-- 	-- 		to_stdin = true,
				-- 	-- 	},
				-- 	-- }));
				-- end,
			},
		},
	},
}
