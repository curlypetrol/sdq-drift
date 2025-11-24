draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título
draw_set_color(c_white);
draw_text(room_width / 2, 80, "Selecciona Nivel (AI)");

// --- COLUMNA 1: FÁCIL ---

/// Botón 1 - Nivel 1
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height, false);
draw_set_color(c_black);
// Nota: Usamos btn1_x + btn_width / 2 para centrar el texto EN EL BOTÓN, no en la sala
draw_text(btn1_x + btn_width / 2, btn1_y + btn_height / 2, "Nivel 1"); 

/// Botón 2 - Nivel 2
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn2_x + btn_width / 2, btn2_y + btn_height / 2, "Nivel 2");


// --- COLUMNA 2: INTERMEDIO ---

/// Botón 3 - Nivel 3
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn3_x + btn_width / 2, btn3_y + btn_height / 2, "Nivel 3");

/// Botón 4 - Nivel 4
if (point_in_rectangle(mouse_x, mouse_y, btn4_x, btn4_y, btn4_x + btn_width, btn4_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn4_x, btn4_y, btn4_x + btn_width, btn4_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn4_x + btn_width / 2, btn4_y + btn_height / 2, "Nivel 4");


// --- COLUMNA 3: INTERMEDIO ALTO ---

/// Botón 5 - Nivel 5
if (point_in_rectangle(mouse_x, mouse_y, btn5_x, btn5_y, btn5_x + btn_width, btn5_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn5_x, btn5_y, btn5_x + btn_width, btn5_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn5_x + btn_width / 2, btn5_y + btn_height / 2, "Nivel 5");

/// Botón 6 - Nivel 6
if (point_in_rectangle(mouse_x, mouse_y, btn6_x, btn6_y, btn6_x + btn_width, btn6_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn6_x, btn6_y, btn6_x + btn_width, btn6_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn6_x + btn_width / 2, btn6_y + btn_height / 2, "Nivel 6");


// --- CENTRADOS ABAJO ---

/// Botón 7 - Nivel 7 (Avanzado)
if (point_in_rectangle(mouse_x, mouse_y, btn7_x, btn7_y, btn7_x + btn_width, btn7_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn7_x, btn7_y, btn7_x + btn_width, btn7_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn7_x + btn_width / 2, btn7_y + btn_height / 2, "Nivel 7 (Avanzado)");

/// Botón SALIR AL MENÚ PRINCIPAL
if (point_in_rectangle(mouse_x, mouse_y, btn_back_x, btn_back_y, btn_back_x + btn_width, btn_back_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn_back_x, btn_back_y, btn_back_x + btn_width, btn_back_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn_back_x + btn_width / 2, btn_back_y + btn_height / 2, "Menú Principal");

/// Botón SALIR DEL JUEGO
if (point_in_rectangle(mouse_x, mouse_y, btn_exit_x, btn_exit_y, btn_exit_x + btn_width, btn_exit_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn_exit_x, btn_exit_y, btn_exit_x + btn_width, btn_exit_y + btn_height, false);
draw_set_color(c_black);
draw_text(btn_exit_x + btn_width / 2, btn_exit_y + btn_height / 2, "Salir del Juego");