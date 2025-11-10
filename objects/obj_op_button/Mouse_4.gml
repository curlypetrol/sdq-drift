// Disminuir vueltas
if (point_in_rectangle(mouse_x, mouse_y, btn_minus_x, btn_minus_y, btn_minus_x + sq_w, btn_minus_y + sq_h)) {
    global.laps_required = clamp(global.laps_required - 1, laps_min, laps_max);
}

// Aumentar vueltas
if (point_in_rectangle(mouse_x, mouse_y, btn_plus_x, btn_plus_y, btn_plus_x + sq_w, btn_plus_y + sq_h)) {
    global.laps_required = clamp(global.laps_required + 1, laps_min, laps_max);
}

// Salir al menú principal
if (point_in_rectangle(mouse_x, mouse_y, btn_back_x, btn_back_y, btn_back_x + btn_back_w, btn_back_y + btn_back_h)) {
    room_goto(rm_main_menu);
}
