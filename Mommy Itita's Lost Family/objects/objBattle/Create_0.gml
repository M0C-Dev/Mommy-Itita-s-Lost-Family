// Variables
units = []
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

battleText = "";

//Make targetting cursor
cursor = 
{
	activeUser : noone,
	activeTarget : noone,
	activeAction : -1,
	targetSide : -1,
	targetIndex : 0,
	targetAll : false,
	confirmDelay : 0,
	active : false
}

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 90;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

//Make enemies
for ( var _i = 0; _i < array_length(enemies); _i++ )
{
	enemyUnits[_i] = instance_create_depth( x+230-(_i*36), y+102,depth-10, objBattleUnitEnemy, enemies[_i] );
	array_push(units, enemyUnits[_i]);
}

//Make party
for ( var _i = 0; _i < array_length(global.party); _i++ )
{
	partyUnits[_i] = instance_create_depth( x+75+(_i*72), y+84,depth-10, objBattleUnitPC, global.party[_i] );
	array_push(units, partyUnits[_i]);
}

//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder, function( _1, _2 )
	{
		return _1.y - _2.y;
	});
}
RefreshRenderOrder();

//State functions
function BattleStateSelectAction()
{
	if ( !instance_exists(objMenu) )
	{
		//Get Current unit
		var _unit = unitTurnOrder[turn];
	
		//Is unit dead or unable to act?
		if ( !instance_exists(_unit) || ( _unit.hp <= 0 ) )
		{
			battleState = BattleStateVictoryCheck;
			exit;
		}
	
		//Sellect an action to perform
		//BeginAction(_unit.id, global.actionLibrary.attack, _unit.id);
	
		if ( _unit.object_index == objBattleUnitPC )
		{
			//Compile Menu
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			
			for ( var i = 0; i < array_length(_actionList); i++ )
			{
				var _action = _actionList[i];
				var _available = true; //CHECAR MP É AQUI!!!
				var _nameAndCount = _action.name; // PARA ITENS COM QUANTIDADE LIMITADA
				//Icon
				var _icon = -1;
				if (variable_struct_exists(_action, "habilityIcon"))
				{
					_icon = _action.habilityIcon;
				}
				
				if (_action.subMenu == -1)
				{
					array_push(_menuOptions, [_nameAndCount, MenuSelectAction, [_unit, _action], _available, _icon]);
				}
				else
				{
					//create or add submenu
					if ( is_undefined(_subMenus[$ _action.subMenu]) )
					{
						variable_struct_set(_subMenus, _action.subMenu, [[_nameAndCount, MenuSelectAction, [_unit, _action], _available, _icon]]);
					} else
					{
						array_push(_subMenus[$ _action.subMenu], [_nameAndCount, MenuSelectAction, [_unit, _action], _available, _icon]);
					}
				}
			}
			
			// turn sub menus into an array
			var _subMenusArray = variable_struct_get_names(_subMenus);
			for ( var i = 0; i < array_length(_subMenusArray); i++ )
			{
				//sort submenu if needed (here)
				
					//add back to sub menu
					array_push(_subMenus[$ _subMenusArray[i]], ["Back", MenuGoBack, -1, true, sprIconBack]);
				//add submenu to main menu
					array_push(_menuOptions, [_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true])
			}
			
			Menu(x, y, _menuOptions);
		}
		else
		{
			var _enemyAction = _unit.AIscript();
			if (_enemyAction != -1)
			{
			BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
			}
		}
	}
}
function BeginAction( _user, _action, _targets )
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	battleText = string_ext(_action.description, [_user.name]);
	if ( !is_array(currentTargets) ) { currentTargets = [currentTargets] };
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with ( _user )
	{
		acting = true;
		//Play user animation if it is defined for that action and that user
		if ( (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation])) )
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	battleState = BattleStatePerformAction;
}

function BattleStatePerformAction()
{
	//If animation etc is still playing
	if ( currentUser.acting )
	{
		//when it ends preform action effect if it exists
		if ( currentUser.image_index >= currentUser.image_number -1 )
		{
			with ( currentUser )
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			if ( variable_struct_exists( currentAction, "effectSprite" ) )
			{
				if ( (currentAction.effectOnTarget == MODE.ALWAYS) || (currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <=1) )
				{
					for ( var i = 0; i < array_length(currentTargets); i++ )
					{
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth-1,objBattleEffect, {sprite_index : currentAction.effectSprite});
					}
				}
				else // play it at 0,0
				{
					var _effectSprite = currentAction.effectSprite;
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) { _effectSprite = currentAction.effectSpriteNoTarget };
					instance_create_depth(x, y, depth-100, objBattleEffect, {sprite_index : _effectSprite})
				}
			}
			currentAction.func(currentUser, currentTargets);
		}
	}
	else // wait for delay and then end turn
	{
		if ( !instance_exists(objBattleEffect) )
		{
			battleWaitTimeRemaining--;
			if ( battleWaitTimeRemaining == 0 )
			{
				battleState = BattleStateVictoryCheck;
			}
		}
	}
}


function BattleStateVictoryCheck()
{
	RefreshPartyHealthOrder = function()
	{
		partyUnitsByHp = [];
		array_copy(partyUnitsByHp, 0, partyUnits, 0, array_length(partyUnits));
		array_sort(partyUnitsByHp, function(_1,_2)
		{
			return _2.hp - _1.hp;
		})
	}
	RefreshPartyHealthOrder();
	
	RefreshEnemiesHealthOrder = function()
	{
		enemiesUnitsByHp = [];
		array_copy(enemiesUnitsByHp, 0, enemyUnits, 0, array_length(enemyUnits));
		array_sort(enemiesUnitsByHp, function(_1,_2)
		{
			return _2.hp - _1.hp;
		})
	}
	RefreshEnemiesHealthOrder();
	
	if ( partyUnitsByHp[0].hp <= 0 )
	{
		instance_destroy();
	}
	if ( enemiesUnitsByHp[0].hp <= 0 )
	{
		//for ( var i = 0; i < array_length(global.party); i++ )
		//{
		//	global.party[i].hp = partyUnits[i].hp;
		//}
		instance_destroy();
	}
	battleState = BattleStateTurnProgression;
}

function BattleStateTurnProgression()
{
	battleText = "";
	turnCount++;
	turn++;
	if ( turn > array_length(unitTurnOrder) - 1 )
	{
		turn = 0;
		roundCount++;
	}
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;