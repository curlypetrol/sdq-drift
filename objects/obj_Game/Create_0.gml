show_debug_overlay(false);

race_running  = false;
race_start_ms = 0;
race_elapsed_ms = 0;   // ms actuales
race_best_ms  = -1;    // -1 = aún no hay mejor tiempo

// empieza cuando entramos al nivel
race_running  = true;
// Asegurar valor global por defecto si aún no se ha pasado por rm_options
if (!variable_global_exists("laps_required")) global.laps_required = 1;

race_start_ms = current_time;
race_elapsed_ms = 0;

// Estado inicial del cronómetro (arranca al entrar a la room)
race_running    = true;
race_start_ms   = current_time;
race_elapsed_ms = 0;

// Laps 
lap_current = 0;                      
lap_need    = global.laps_required;     

// Anti-trampa 
passed_checkpoint = false;

visible = true;
