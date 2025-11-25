// Variables locales
var _terr = tile_terrain(x, y); 
var _max_speed = (_terr == "asphalt") ? max_asphalt : max_offroad;

// Gestión estados
if (state == PlayerState.BOOST) {
    _max_speed = max_boost; 
    boost_timer--;
    if (boost_timer <= 0) state = PlayerState.NORMAL;
}

if (state == PlayerState.OIL) {
    oil_timer--;
    if (oil_timer <= 0) state = PlayerState.NORMAL;
}

// Físicas movimiento
var _can_control = (state != PlayerState.OIL) && (state != PlayerState.DEAD) && (obj_Game.race_running);

if (_can_control) {
    // Girar
    if (input_left)  facing += turn_rate;
    if (input_right) facing -= turn_rate;
    
    // Acelerar
    vx += lengthdir_x(base_accel, facing);
    vy += lengthdir_y(base_accel, facing);
} 
else if (state == PlayerState.OIL) {
    // Descontrol
    facing += irandom_range(-3, 3);
}

// Fricción
var _fric = friction_val; 
if (state == PlayerState.OIL) _fric *= 0.35;

vx *= (1 - _fric * (1 - drift_keep));
vy *= (1 - _fric * (1 - drift_keep));

// Limitar velocidad
var _spd = point_distance(0, 0, vx, vy);

if (_spd > _max_speed) {
    var _dir = point_direction(0, 0, vx, vy);
    vx = lengthdir_x(_max_speed, _dir);
    vy = lengthdir_y(_max_speed, _dir);
}

// Audio motor
var engine_vol = _spd / max_asphalt;
engine_vol = clamp(engine_vol, 0.1, 1.0);
if (audio_is_playing(engine_sound_inst)) {
    audio_sound_gain(engine_sound_inst, engine_vol, 0);
}

// Colisión pared
var front_x = x + lengthdir_x(sprite_height * 0.001, facing);
var front_y = y + lengthdir_y(sprite_height * 0.001, facing);

if (place_meeting(front_x, front_y, obj_wall)) {
	state = PlayerState.STOPPED
    move_contact_solid(point_direction(0,0,vx,vy), 0.01);
    vx = 0;
    vy = 0;
    if (_spd > 1.5 && !audio_is_playing(snd_crash)) { 
        audio_play_sound(snd_crash, 10, false);
    }
}

// Mover y colisiones
var nx = x + vx;
var ny = y + vy;

if (!place_meeting(nx, ny, obj_Block)) {
    x = nx; 
    y = ny;
} else {
    var hit = instance_place(nx, ny, obj_Block);
    if (hit != noone) {
        var motion_dir = point_direction(0,0,vx,vy);
        var to_hit = point_direction(x, y, hit.x, hit.y);
        var ang = angle_difference(motion_dir, to_hit);
        
        // Muerte frontal
        if (abs(ang) < front_kill_cone && _spd >= min_kill_speed) {
             if (_spd > 1.5 && !audio_is_playing(snd_crash)) audio_play_sound(snd_crash, 10, false);
             
             if (variable_instance_exists(id, "player_die")) player_die(id); 
             else state = PlayerState.DEAD; 
        } else {
             // Rebote
             move_contact_solid(motion_dir, 1);
             vx *= 0.3;
             vy *= 0.3;
             if (_spd > 1.5 && !audio_is_playing(snd_crash)) audio_play_sound(snd_crash, 10, false);
        }
    } else {
        // Colisión simple
        move_contact_solid(point_direction(0,0,vx,vy), 1);
        vx = 0; vy = 0;
    }
}

// Rotación sprite
image_angle = facing;