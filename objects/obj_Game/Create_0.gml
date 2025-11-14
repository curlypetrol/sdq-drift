// Evento Create de obj_Game (CORREGIDO)

show_debug_overlay(false);

// Aquí SÓLO inicializamos las variables.
// NO le decimos al juego que inicie.
race_running  = false;
race_start_ms = 0;
race_elapsed_ms = 0;   // ms actuales
race_best_ms  = -1;    // -1 = aún no hay mejor tiempo

// Asegurar valor global por defecto
if (!variable_global_exists("laps_required")) global.laps_required = 1;

// Laps 
lap_current = 0;                      
lap_need    = global.laps_required;     

// Anti-trampa 
passed_checkpoint = false;

visible = true;