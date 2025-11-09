// Mensajes en la esquina de la pantalla
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var spd = point_distance(0,0,vx,vy);
draw_text(16, 16, "SPD: " + string_format(spd, 0, 2));

var st = "NORMAL";
if (state == PlayerState.OIL)   st = "OIL";
if (state == PlayerState.BOOST) st = "BOOST";
if (state == PlayerState.DEAD)  st = "DEAD";
draw_text(16, 36, "STATE: " + st);

draw_text(16, 56, "TERRAIN: " + tile_terrain(x,y));
