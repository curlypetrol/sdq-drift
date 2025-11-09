// NIVEL 1
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height)) {
    room_goto(rm_Level1);
}

// NIVEL 2
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height)) {
    room_goto(rm_Level2);
}

// NIVEL 3
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height)) {
    room_goto(rm_Level3);
}

// SALIR
if (point_in_rectangle(mouse_x, mouse_y, btn_exit_x, btn_exit_y, btn_exit_x + btn_width, btn_exit_y + btn_height)) {
    game_end();
}
