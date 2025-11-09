var g = instance_find(obj_Game, 0);
if (g != noone) {
    g.race_running = false;
    var final_ms = g.race_elapsed_ms;

    // guarda mejor tiempo (si no había o si es menor)
    if (g.race_best_ms < 0 || final_ms < g.race_best_ms) {
        g.race_best_ms = final_ms;
    }

    // pasar de nivel
    var nxt = room_next(room);
    if (nxt != -1) room_goto(nxt); else room_restart();
}
