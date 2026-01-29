Menu(x+8, y+8,
[
	["Fight", -1, -1, true],
	["Magic", SubMenu,
		[[
			["Hatch", -1, -1, true],
			["Back", MenuGoBack, -1, true]
		]],
		true
	],
	["Escape", -1, -1, true]
]);