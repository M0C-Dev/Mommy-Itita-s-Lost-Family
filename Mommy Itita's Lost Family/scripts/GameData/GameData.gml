//Action Data
global.actionLibrary =
{
	attack :
	{
		name : "Attack",
		description : "{0} attacks!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		//effectSprite : sprDebugAnimation,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength *0.25, _user.strength * 0.25));
			BattleChangeHP( _targets[0], -_damage, 0 )
			_targets[0].hitFlashAlpha = 1;
		}
	}
}
enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

// Party Data
global.party =
[
	{
		name : "Itita",
		hp : 30,
		hpMax : 30,
		mp : 10,
		mpMax : 10,
		strength : 2,
		critChance : 100,
		sprites : { idle:sprPortraitPlayerIdle, attack:sprPortraitPlayerAttack, defend:sprPortraitPlayerIdle, down:sprPortraitPlayerDown },
		actions : []
	},
];

// Enemies Data
global.enemies =
{
	Plant:
	{
		name : "Plant",
		hp : 5,
		hpMax : 5,
		mp: 5,
		mpMax : 5,
		strength : 6,
		critChance : 10,
		sprites : { idle:sprPortraitFlowerPotIdle, attack:sprPortraitFlowerPotIdle, defend:sprPortraitFlowerPotIdle, down:sprPortraitFlowerPotBroken },
		actions : [global.actionLibrary.attack],
		xpValue : 15,
		AIscript : function()
		{
			// attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(objBattle.partyUnits, function(_unit, _index)
			{
				return ( _unit.hp > 0 );
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target]
		}
	}
};