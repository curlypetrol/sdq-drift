facing = 0;         
vx = 0; vy = 0;

base_accel   = 0.25;
turn_rate    = 3.0;   
friction     = 0.20  
drift_keep   = 1.0;  

max_asphalt  = 4.2;
max_offroad  = 2.8;
max_boost    = 5.8;

state = PlayerState.NORMAL;
oil_timer = 0;
boost_timer = 0;

front_kill_cone = 50;    
min_kill_speed  = 2.0;   

sprite_looks_up = false;

// Variables para guardar los sonidos en bucle
engine_sound_inst = noone;
brake_sound_inst = noone;

// Intentar reproducir sonido
engine_sound_inst = audio_play_sound(snd_acceleration, 1, true);

// Verificar si el sonido realmente está sonando antes de tocarlo
if (audio_is_playing(engine_sound_inst)) {
    audio_sound_gain(engine_sound_inst, 0, 0);
}

is_bot = false;
ai_left = false;
ai_right = false;
