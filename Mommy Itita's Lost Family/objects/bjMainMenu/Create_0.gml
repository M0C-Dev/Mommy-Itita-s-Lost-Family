Menu(
	x,
	y,
	[
		// Start Game
		[
			"Start Game",
			function() {
				room_goto_next();
			},
			-1,
			true
		],

		// Settings (Submenu)
		[
			"Settings",
			SubMenu,
			[[
				["Window Size", -1, -1, true],
				["Master Volume", -1, -1, true],
				["Music Volume", -1, -1, true],
				["SFX Volume", -1, -1, true],
				["Back", MenuGoBack, -1, true, sprIconBack]
			]],
			true
		],

		// Quit
		[
			"Quit",
			function() {
				game_end();
			},
			-1,
			true
		]
	]
);

with (objMenu)
{
	x = room_width * 0.5 - widthFull * 0.5;
	//y = room_height * 0.5 - heightFull * 0.5;
}