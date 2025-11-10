// Controlador de carrera
var g = instance_find(obj_Game, 0);
if (g == noone) exit;

// Debe haber pasado por checkpoint antes de poder contar vuelta
if (!g.passed_checkpoint) exit;

// Lado actual vs lado previo del jugador respecto a la meta
var s_now  = side_sign(x0, y0, nx, ny, other.x, other.y);
if (!variable_instance_exists(other, "__lap_side_prev")) {
    other.__lap_side_prev = s_now;
    exit;
}

var s_prev = other.__lap_side_prev;
var crossed = (s_prev != 0) && (s_now != 0) && (s_prev != s_now);
var vdot_n  = other.vx * nx + other.vy * ny;
var forward = (vdot_n > 0);

var speed_now = point_distance(0,0, other.vx, other.vy);
var fast_enough = (speed_now >= 1.0);

if (crossed && forward && fast_enough) {
    g.lap_current += 1;
    g.passed_checkpoint = false;     

    if (g.lap_current >= g.lap_need) {
        g.race_running = false;
        var rmMenu = asset_get_index("rm_main_menu");
        if (rmMenu != -1) room_goto(rmMenu); else room_restart();
    }
}

other.__lap_side_prev = s_now;
