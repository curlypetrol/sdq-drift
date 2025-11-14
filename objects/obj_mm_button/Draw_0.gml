draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título
draw_set_color(c_white);
draw_text(room_width / 2, 80, "SDQ Drift");

// Función rápida para dibujar botón (sin funciones reales, solo repetición)
/// Botón 1 - Jugar
if (point_in_rectangle(mouse_x, mouse_y, btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn1_x, btn1_y, btn1_x + btn_width, btn1_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn1_y + btn_height / 2, "Jugar");

/// Botón 2 - Opciones
if (point_in_rectangle(mouse_x, mouse_y, btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn2_x, btn2_y, btn2_x + btn_width, btn2_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn2_y + btn_height / 2, "Opciones");

/// Botón 3 - Salir
if (point_in_rectangle(mouse_x, mouse_y, btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn3_x, btn3_y, btn3_x + btn_width, btn3_y + btn_height, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn3_y + btn_height / 2, "Salir");
