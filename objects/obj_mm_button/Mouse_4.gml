// Jugar
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height)) {
    room_goto(rm_menu);
}

// Opciones
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height)) {
    room_goto(rm_options);
}

// Salir
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height)) {
    game_end();
}