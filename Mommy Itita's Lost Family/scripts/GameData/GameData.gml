//Action Data
global.actionLibrary =
{
	attack :
	{
		name : "Insult",
		description : "{0} insults his mom!",
		subMenu : "Attacks",
		targetRequired : true,
		targetType : TARGET_TYPE.ENEMY,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		//effectSprite : sprDebugAnimation,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength *0.25, _user.strength * 0.25));
			BattleChangeHP( _targets[0], -_damage, 0 )
		}
	},
	shock :
	{
		name : "Shock",
		description : "{0} use shock!",
		subMenu : "Abilities",
		epCost : 2,
		targetRequired : true,
		targetType : TARGET_TYPE.ENEMY,
		targetEnemyByDefault : true,
		targetAll : MODE.ALWAYS,
		userAnimation : "shock",
		//effectSprite : sprDebugAnimation,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for ( var i = 0; i < array_length(_targets); i++; )
			{
				var _damage = irandom_range(2,10);
				if (array_length(_targets) > 1)
				{
					_damage = ceil(_damage*0.75)
				}
				BattleChangeHP( _targets[i], -_damage, 0 );
			}
		}
	},
	cure :
	{
		name : "Cure",
		description : "{0} use cure!",
		subMenu : "Abilities",
		epCost : 2,
		targetRequired : true,
		targetType : TARGET_TYPE.ALLY,
		targetEnemyByDefault : false,
		targetAll : MODE.NEVER,
		userAnimation : "cure",
		//effectSprite : sprDebugAnimation,
		effectOnTarget : MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for ( var i = 0; i < array_length(_targets); i++; )
			{
				var _cure = irandom_range(2,5);
				if (array_length(_targets) > 1)
				{
					_cure = ceil(_cure*0.75)
				}
				BattleChangeHP( _targets[i], _cure, 0 );
			}
		}
	}
}

// Party Data
global.party =
[
	{
		name : "Itita",
		hp : 30,
		hpMax : 30,
		ep : 10,
		epMax : 10,
		strength : 2,
		critChance : 100,
		sprites : { 
			idle:sprPortraitPlayerIdle, 
			attack:sprPortraitPlayerAttack, 
			defend:sprPortraitPlayerIdle, 
			down:sprPortraitPlayerDown, 
			shock:sprPortraitPlayerShock, 
			cure:sprPortraitPlayerCure
		},
		actions : [global.actionLibrary.attack, global.actionLibrary.shock, global.actionLibrary.cure]
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
		ep: 5,
		epMax : 5,
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

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}
enum TARGET_TYPE
{
	ENEMY = 0,
	ALLY = 1,
	BOTH = 2
}