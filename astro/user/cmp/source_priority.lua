
local order = {
    -- 'copilot',
    'nvim_lsp',
    'luasnip',
    'buffer',
    'path',
}

local scores = {}
for i, v in ipairs(order) do
    scores[v] = (#order - i + 1) * 2
end


return scores
