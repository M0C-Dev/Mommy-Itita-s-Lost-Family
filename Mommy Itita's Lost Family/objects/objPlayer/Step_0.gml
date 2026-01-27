// Random ass variables

right_key = keyboard_check(vk_right);
up_key = keyboard_check(vk_up);
left_key = keyboard_check(vk_left);
down_key = keyboard_check(vk_down);

// Get xspd and yspd
xspd = ( right_key - left_key ) * move_spd;
yspd = ( down_key - up_key ) * move_spd;

// Pause
if ( instance_exists(objPauser) )
{
	xspd = 0;
	yspd = 0;
}

// Set sprite
mask_index = sprite[DOWN];
// x
if ( yspd == 0 )
{
    if ( xspd > 0 ) { face = RIGHT };
    if ( xspd < 0 ) { face = LEFT };    
}
if ( xspd > 0 && face == LEFT ) { face = RIGHT };
if ( xspd < 0 && face == RIGHT ) { face = LEFT }; 

// y
if ( xspd  == 0 )
{
    if ( yspd > 0 ) { face = DOWN };
    if ( yspd < 0 ) { face = UP };   
}
if ( yspd > 0 && face == UP ) { face = DOWN };
if ( yspd < 0 && face == DOWN ) { face = UP };

sprite_index = sprite[face];

// Collision code
if (place_meeting( x + xspd, y, objWall ))
{
    xspd = 0;
}
if (place_meeting( x, y + yspd, objWall ))
{
    yspd = 0;
}


// Move mommy
x += xspd;
y += yspd;

// Animate
if ( xspd == 0 && yspd == 0 )
{
    image_index = 0;
}

// Depth
depth = -bbox_bottom;