draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título
draw_set_color(c_white);
draw_text(room_width / 2, 80, "Opciones");

// ---- Fila principal: [ Vueltas ] [ - ] [ valor ] [ + ] ----

// Rectángulo "Vueltas" (informativo, no clickable)
draw_set_color(c_white);
draw_rectangle(label_x, label_y, label_x + label_w, label_y + label_h, false);
draw_set_color(c_black);
draw_text(label_x + label_w/2, label_y + label_h/2, "Vueltas");

// Botón "-" 
if (point_in_rectangle(mouse_x, mouse_y, btn_minus_x, btn_minus_y, btn_minus_x + sq_w, btn_minus_y + sq_h))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn_minus_x, btn_minus_y, btn_minus_x + sq_w, btn_minus_y + sq_h, false);
draw_set_color(c_black);
draw_text(btn_minus_x + sq_w/2, btn_minus_y + sq_h/2, "-");

// Recuadro del valor
draw_set_color(c_white);
draw_rectangle(val_x, val_y, val_x + val_w, val_y + val_h, false);
draw_set_color(c_black);
draw_text(val_x + val_w/2, val_y + val_h/2, string(global.laps_required));

// Botón "+"
if (point_in_rectangle(mouse_x, mouse_y, btn_plus_x, btn_plus_y, btn_plus_x + sq_w, btn_plus_y + sq_h))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn_plus_x, btn_plus_y, btn_plus_x + sq_w, btn_plus_y + sq_h, false);
draw_set_color(c_black);
draw_text(btn_plus_x + sq_w/2, btn_plus_y + sq_h/2, "+");

// ---- Botón SALIR AL MENÚ PRINCIPAL ----
if (point_in_rectangle(mouse_x, mouse_y, btn_back_x, btn_back_y, btn_back_x + btn_back_w, btn_back_y + btn_back_h))
    draw_set_color(c_yellow);
else
    draw_set_color(c_white);

draw_rectangle(btn_back_x, btn_back_y, btn_back_x + btn_back_w, btn_back_y + btn_back_h, false);
draw_set_color(c_black);
draw_text(room_width / 2, btn_back_y + btn_back_h / 2, "Salir a menu principal");
