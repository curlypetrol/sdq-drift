show_debug_overlay(false);

race_running  = false;
race_start_ms = 0;
race_elapsed_ms = 0;   // ms actuales
race_best_ms  = -1;    // -1 = aún no hay mejor tiempo

// empieza cuando entramos al nivel
race_running  = true;
race_start_ms = current_time;
race_elapsed_ms = 0;
