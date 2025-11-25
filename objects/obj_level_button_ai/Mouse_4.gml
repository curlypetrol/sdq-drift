// --- COLUMNA 1: FÁCILES ---

// NIVEL 1
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height)) {
    room_goto(rm_lvl_AI1);
}

// NIVEL 2
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height)) {
    room_goto(rm_lvl_AI2);
}


// --- COLUMNA 2: INTERMEDIOS ---

// NIVEL 3
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height)) {
    room_goto(rm_lvl_AI3);
}

// NIVEL 4
if (point_in_rectangle(mouse_x, mouse_y, btn4_x, btn4_y, btn4_x + btn_width, btn4_y + btn_height)) {
    room_goto(rm_lvl_AI4);
}


// --- COLUMNA 3: INTERMEDIO ALTO ---

// NIVEL 5
if (point_in_rectangle(mouse_x, mouse_y, btn5_x, btn5_y, btn5_x + btn_width, btn5_y + btn_height)) {
    room_goto(rm_lvl_AI5);
}

// NIVEL 6
if (point_in_rectangle(mouse_x, mouse_y, btn6_x, btn6_y, btn6_x + btn_width, btn6_y + btn_height)) {
    room_goto(rm_lvl_AI6);
}


// --- CENTRADOS ABAJO ---

// NIVEL 7 (AVANZADO)
if (point_in_rectangle(mouse_x, mouse_y, btn7_x, btn7_y, btn7_x + btn_width, btn7_y + btn_height)) {
    room_goto(rm_lvl_AI7);
}

// VOLVER ATRÁS (Al menú de selección de modo)
// Nota: Verifica si tu menú principal se llama "rm_menu" o "rm_main_menu" y ajusta aquí si es necesario.
if (point_in_rectangle(mouse_x, mouse_y, btn_back_x, btn_back_y, btn_back_x + btn_width, btn_back_y + btn_height)) {
    room_goto(rm_main_menu); 
}

// SALIR DEL JUEGO
if (point_in_rectangle(mouse_x, mouse_y, btn_exit_x, btn_exit_y, btn_exit_x + btn_width, btn_exit_y + btn_height)) {
    game_end();
}