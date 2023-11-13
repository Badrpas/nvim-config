return {
	disabled = {
		"tsserver",
	},
	filter = function (client)
		print('user filter', client.name);
		if client.name == 'tsserver' then return false end
		return true
	end,
	top = "kekio",
}
