local ls = require("luasnip")
local s = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local f = ls.function_node

local module_name = function()
	return vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")
end

local component_name = function()
	local name = module_name()
	name = name:gsub("[-%.]?(%l)(%w+)", function(a, b)
		return string.upper(a) .. b
	end)
	name = name:gsub("_", "")
	return name
end


-- Snippet nodes are updated multiple times per expansion. 
-- We use last_name to remove previous COMPONENT_IMPL block in c files
local last_name = ''
vim.api.nvim_create_autocmd("User", {
	pattern = "LuasnipPreExpand",
	callback = function()
		last_name = ''
	end
})

local write_impl = function (args)
	local hfile = vim.fn.expand('%')
	local cfile = hfile:gsub('h$', 'c')

  	local hfilename = vim.fn.fnamemodify(vim.fn.expand('%'), ':t')
	local comp_name = args[1][1];

	os.execute("cat " .. cfile .. " | grep '#include \""..hfilename.."\"' || echo '#include \"".. hfilename .."\"\\n\\n' >> " .. cfile)
	os.execute("cat " .. cfile .. " | grep 'COMPONENT_IMPL(" .. comp_name .. ")' || echo 'COMPONENT_IMPL(" .. comp_name .. ");' >> " .. cfile)

	os.execute([[sed -i '/COMPONENT_IMPL()/d' ]] .. cfile);
	if last_name ~= comp_name then
		os.execute([[sed -i '/COMPONENT_IMPL(]] .. last_name .. [[)/d' ]] .. cfile);
	end
	print("Did sed thing with ", last_name, " current: ", comp_name)

	last_name = comp_name

	return ''
end

return {
	s({
		trig = "comp",
		name = "ECS Component decl",
		dscr = "ECS Component Declaration for custom engine",
	}, {
		text({
			"typedef struct {",
			"    ",
		}),
		insert(2),
		text({ "", "} " }),
		insert(1),
		text({ ";", '', ''}),
		text({ "COMPONENT_DECL(" }), 
			f(function (args) return args[1][1] end, {1}),
		text({ ");" }),
		f(write_impl, {1}),
	}),
}

