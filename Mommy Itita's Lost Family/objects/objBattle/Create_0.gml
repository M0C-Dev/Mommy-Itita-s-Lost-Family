
units = []

//Make enemies
for ( var _i = 0; _i < array_length(enemies); _i++ )
{
	enemyUnits[_i] = instance_create_depth( x+223-(_i*24), y+104,depth-10, objBattleUnitEnemy, enemies[_i] );
	array_push(units, enemyUnits[_i]);
}

//Make party
for ( var _i = 0; _i < array_length(global.party); _i++ )
{
	partyUnits[_i] = instance_create_depth( x+64+(_i*24), y+104,depth-10, objBattleUnitPC, global.party[_i] );
	array_push(units, partyUnits[_i]);
}