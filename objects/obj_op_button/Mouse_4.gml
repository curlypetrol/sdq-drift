// 1. Lógica Vueltas
if (point_in_rectangle(mouse_x, mouse_y, btn_minus_x, btn_minus_y, btn_minus_x + sq_w, btn_minus_y + sq_h)) {
    global.laps_required = clamp(global.laps_required - 1, laps_min, laps_max);
}
if (point_in_rectangle(mouse_x, mouse_y, btn_plus_x, btn_plus_y, btn_plus_x + sq_w, btn_plus_y + sq_h)) {
    global.laps_required = clamp(global.laps_required + 1, laps_min, laps_max);
}

// 2. Lógica Configurar IA (NUEVO)
// IMPORTANTE: Debes crear una room llamada rm_nn_config
if (point_in_rectangle(mouse_x, mouse_y, btn_nn_x, btn_nn_y, btn_nn_x + btn_nn_w, btn_nn_y + btn_nn_h)) {
    room_goto(rm_nn_config); 
}

// 3. Lógica Salir
if (point_in_rectangle(mouse_x, mouse_y, btn_back_x, btn_back_y, btn_back_x + btn_back_w, btn_back_y + btn_back_h)) {
    room_goto(rm_main_menu);
}