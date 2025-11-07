// Timers de estados
if (state == PlayerState.OIL) {
    oil_timer -= 1;
    if (oil_timer <= 0) state = PlayerState.NORMAL;
}
if (state == PlayerState.BOOST) {
    boost_timer -= 1;
    if (boost_timer <= 0) state = PlayerState.NORMAL;
}

// Velocidad por terreno o boost
var terr = tile_terrain(x, y);
var max_speed = (terr == "asphalt") ? max_asphalt : max_offroad;
if (state == PlayerState.BOOST) max_speed = max_boost;

// Controlar dirección de vehículo
var left  = keyboard_check(vk_left);
var right = keyboard_check(vk_right);

var can_control = (state != PlayerState.OIL) && (state != PlayerState.DEAD);

if (can_control) {
    if (left)  facing -= turn_rate;
    if (right) facing += turn_rate;
} else if (state == PlayerState.OIL) {
    facing += irandom_range(-3, 3);
}

// Aceleración constante
var ax = lengthdir_x(base_accel, facing);
var ay = lengthdir_y(base_accel, facing);
vx += ax; vy += ay;

// Fricción cuano se pasa por aceite
var fric = friction;
if (state == PlayerState.OIL) fric *= 0.35;
vx *= (1 - fric * (1 - drift_keep));
vy *= (1 - fric * (1 - drift_keep));

// Límite de velocidad
var spd = point_distance(0,0,vx,vy);
if (spd > max_speed) {
    var dirv = point_direction(0,0,vx,vy);
    vx = lengthdir_x(max_speed, dirv);
    vy = lengthdir_y(max_speed, dirv);
}

// Movimiento y colisión con bloques
var nx = x + vx;
var ny = y + vy;

if (!place_meeting(nx, ny, obj_Block)) {
    x = nx; y = ny;
} else {
    var hit = instance_place(nx, ny, obj_Block);
    if (hit != noone) {
        var motion_dir = point_direction(0,0,vx,vy);
        var to_hit = point_direction(x, y, hit.x, hit.y);
        var ang = angle_difference(motion_dir, to_hit);
        var speed_now = spd;

        if (abs(ang) < front_kill_cone && speed_now >= min_kill_speed) {
            player_die(id);
        } else {
            move_contact_solid(motion_dir, 1);
            vx *= 0.3; vy *= 0.3;
        }
    } else {
        move_contact_solid(point_direction(0,0,vx,vy), 1);
        vx = 0; vy = 0;
    }
}

// Orientación
image_angle = facing;
