// Botón 1: Human Player (Antes Jugar) -> Va a rm_menu
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height)) {
    room_goto(rm_menu);
}

// Botón 2: AI Player (NUEVO) -> Va a rm_menu_AI
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height)) {
    room_goto(rm_menu_AI); 
}

// Botón 3: Opciones (Antes estaba en el 2) -> Va a rm_options
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height)) {
    room_goto(rm_options);
}

// Botón 4: Salir (Antes estaba en el 3) -> Cierra el juego
if (point_in_rectangle(mouse_x, mouse_y, btn4_x, btn4_y, btn4_x + btn_width, btn4_y + btn_height)) {
    game_end();
}