// Variables
units = []
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

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
	enemyUnits[_i] = instance_create_depth( x+214-(_i*36), y+102,depth-10, objBattleUnitEnemy, enemies[_i] );
	array_push(units, enemyUnits[_i]);
}

//Make party
for ( var _i = 0; _i < array_length(global.party); _i++ )
{
	partyUnits[_i] = instance_create_depth( x+91+(_i*72), y+84,depth-10, objBattleUnitPC, global.party[_i] );
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
		// attack random party member
		var _action = global.actionLibrary.attack;
		var _possibleTargets = array_filter(objBattle.enemyUnits, function(_unit, _index)
		{
			return ( _unit.hp > 0 );
		});
		var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
		BeginAction(_unit.id, _action, _target);
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
function BeginAction( _user, _action, _targets )
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
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
	battleState = BattleStateTurnProgression;
}

function BattleStateTurnProgression()
{
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