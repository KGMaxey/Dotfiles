local options = {
	opt = {
		expandtab = true,
		shiftwidth = 2,
		tabstop = 2
	},
	g = {},
	t = {}
}

for scope, table in pairs(options) do
	for setting, value in pairs(table) do
		vim[scope][setting] = value
	end
end
