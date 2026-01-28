
y = base_y + sin((timer + x) * 0.03) * 10;

timer++;
if (timer > 100000) timer = 0;