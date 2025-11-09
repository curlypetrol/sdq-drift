draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título
draw_set_color(c_white);
draw_text(room_width / 2, 80, "Selecciona un nivel");

// Función rápida para dibujar botón (sin funciones reales, solo repetición)
/// Botón 1 - Nivel 1
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn1_y + btn_height / 2, "Nivel 1");

/// Botón 2 - Nivel 2
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn2_y + btn_height / 2, "Nivel 2");

/// Botón 3 - Nivel 3
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn3_y + btn_height / 2, "Nivel 3");

/// Botón SALIR
if (point_in_rectangle(mouse_x, mouse_y, btn_exit_x, btn_exit_y, btn_exit_x + btn_width, btn_exit_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn_exit_x, btn_exit_y, btn_exit_x + btn_width, btn_exit_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn_exit_y + btn_height / 2, "Salir");
