
// Party Data
global.party =
[
	{
		name: "Itíta",
		hp: 15,
		hpMax: 15,
		mp: 10,
		mpMax: 10,
		strength: 6,
		sprites : { idle:sprPlayerRight, attack:sprPlayerRight, defend:sprPlayerRight, down:sprPlayerRight },
		actions : []
	}
];

// Enemies Data
global.enemies =
{
	Plant:
	{
		name: "Plant",
		hp: 5,
		hpMax: 5,
		mp: 5,
		mpMax: 5,
		strength: 2,
		sprites : { idle:sprPlantPot, attack:sprPlantPot, defend:sprPlantPot, down:sprPlantPot },
		actions : [],
		xpValue: 15,
		AIscript: function()
		{
			// IA inimigo!
		}
	}
};