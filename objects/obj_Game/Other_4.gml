// Evento Room Start de obj_Game

// NO empezamos la carrera todavía
race_running    = false;

// Reiniciar vueltas
lap_current = 0;
lap_need    = global.laps_required;
passed_checkpoint = false;

// ¡Reproducir el sonido de inicio!
audio_play_sound(snd_ready_go, 10, false);

// El sonido dura 4.05 segundos.
var room_fps = game_get_speed(gamespeed_fps);
alarm[0] = 4.05 * room_fps;

// Reiniciar el cronómetro visualmente
race_elapsed_ms = 0;