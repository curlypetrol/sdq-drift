

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

// Movimiento del jugador si es humano o es bot
var left = false;
var right = false;

if (variable_instance_exists(id, "is_bot") && is_bot) {
   
    left = variable_instance_exists(id, "ai_left") ? ai_left : false;
    right = variable_instance_exists(id, "ai_right") ? ai_right : false;
} 
else {
    left = keyboard_check(vk_left);
    right = keyboard_check(vk_right);
}


var can_control = (state != PlayerState.OIL) && (state != PlayerState.DEAD) && (obj_Game.race_running);



if (can_control) {
    // 1. Girar
    if (left)  facing += turn_rate;
    if (right) facing -= turn_rate;
    

    var ax = lengthdir_x(base_accel, facing);
    var ay = lengthdir_y(base_accel, facing);
    vx += ax; vy += ay;
    
} else if (state == PlayerState.OIL) {
    facing += irandom_range(-3, 3);
}

var fric = friction;
if (state == PlayerState.OIL) fric *= 0.35;
vx *= (1 - fric * (1 - drift_keep));
vy *= (1 - fric * (1 - drift_keep));


var spd = point_distance(0,0,vx,vy); // 'spd' se calcula aquí
if (spd > max_speed) {
    var dirv = point_direction(0,0,vx,vy);
    vx = lengthdir_x(max_speed, dirv);
    vy = lengthdir_y(max_speed, dirv);
}




var engine_vol = spd / max_asphalt;
engine_vol = clamp(engine_vol, 0.1, 1.0);

if (audio_is_playing(engine_sound_inst)) {
    audio_sound_gain(engine_sound_inst, engine_vol, 0);
}



var is_braking = (left || right) && (spd > 1.0) && can_control;

if (is_braking) {
    // 1. Intentar reproducir sonido de derrape/freno
    if (!audio_is_playing(brake_sound_inst)) {
        // OPTIMIZACIÓN: Solo reproducir si es Humano (!is_bot) O si es el Bot Elite (log_stats)
        // Esto evita que 20 bots saturen el audio
        var _should_play = !is_bot;
        if (variable_instance_exists(id, "log_stats") && log_stats) _should_play = true;
        
        if (_should_play) {
            brake_sound_inst = audio_play_sound(snd_brake, 5, true);
        }
    }
    
    // 2. Ajustar volumen (SOLUCIÓN DEL ERROR)
    // Solo ajustamos la ganancia si el sonido REALMENTE se está reproduciendo
    if (audio_is_playing(brake_sound_inst)) {
        var brake_vol = clamp(spd / max_asphalt, 0.3, 1.0);
        audio_sound_gain(brake_sound_inst, brake_vol, 0);
    }

} else {
    // Detener sonido si dejamos de frenar
    if (audio_is_playing(brake_sound_inst)) {
        audio_stop_sound(brake_sound_inst);
        brake_sound_inst = noone; 
    }
}

var front_x = x + lengthdir_x(sprite_height * 0.001, facing);
var front_y = y + lengthdir_y(sprite_height * 0.001, facing);

if (place_meeting(front_x, front_y, obj_wall)) {
	move_contact_solid(point_direction(0,0,vx,vy), 0.01);
	vx = 0;
	vy = 0;
    
    if (spd > 1.5 && !audio_is_playing(snd_crash)) { 
        audio_play_sound(snd_crash, 10, false); 
    }
}

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
        var speed_now = spd; // 'speed_now' es lo mismo que 'spd'

        if (abs(ang) < front_kill_cone && speed_now >= min_kill_speed) {

            if (spd > 1.5 && !audio_is_playing(snd_crash)) { 
                audio_play_sound(snd_crash, 10, false); 
		
            }
            player_die(id);
        } else {
            move_contact_solid(motion_dir, 1);
            vx *= 0.3; vy *= 0.3;
            
            if (spd > 1.5 && !audio_is_playing(snd_crash)) { 
                audio_play_sound(snd_crash, 10, false); 
            }
        }
    } else {
        move_contact_solid(point_direction(0,0,vx,vy), 1);
        vx = 0; vy = 0;
    }
}

image_angle = facing;