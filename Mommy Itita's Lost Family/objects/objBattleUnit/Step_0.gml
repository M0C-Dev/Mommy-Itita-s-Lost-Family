if (hp <= 0)
{
	sprite_index = sprites.down;
}
else
{
	if (sprite_index == sprites.down)
	{
		sprite_index = sprites.idle;
	}
}

// Wave movement
var _valor_0_a_10 = clamp( (hp / hpMax) * 10, 0, 10 );
y = base_y + sin((timer + x) * 0.03) * (3+_valor_0_a_10);
timer++;
if (timer > 100000) timer = 0;
