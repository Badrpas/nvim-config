return function(M)

	-- if M.n.gd then
	-- 	M.n.gd[1] = function()
	-- 		vim.lsp.buf.definition()
	-- 	end
	-- end
	-- if M.n.gI then
	-- 	M.n.gI[1] = function()
	-- 		vim.lsp.buf.implementation()
	-- 	end
	-- end
	-- if M.n.gr then
	-- 	M.n.gr[1] = function()
	-- 		vim.lsp.buf.references()
	-- 	end
	-- end
	-- if M.n.gy then
	-- 	M.n.gy[1] = function()
	-- 		vim.lsp.buf.type_definition()
	-- 	end
	-- end
	-- if M.n["<leader>lG"] then
	-- 	M.n["<leader>lG"][1] = function()
	-- 		vim.lsp.buf.workspace_symbol()
	-- 	end
	-- end
	-- if M.n["<leader>lR"] then
	-- 	M.n["<leader>lR"][1] = function()
	-- 		vim.lsp.buf.references()
	-- 	end
	-- end

	M.n["gu"] = M.n["gr"]
	M.n["<c-q>"] = M.n["K"]
	M.n.K = nil

	return M
end
