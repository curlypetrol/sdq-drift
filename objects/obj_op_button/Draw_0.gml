draw_set_font(-1); // O tu fuente personalizada fnt_game
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título
draw_set_color(c_white);
draw_text(room_width / 2, 80, "OPCIONES");

// ------------------------------------------
// 1. FILA VUELTAS
// ------------------------------------------
// Etiqueta "Vueltas"
draw_set_color(c_white);
draw_rectangle(label_x, label_y, label_x + label_w, label_y + label_h, false);
draw_set_color(c_black);
draw_text(label_x + label_w/2, label_y + label_h/2, "Vueltas");

// Botón "-" 
var _hover_minus = point_in_rectangle(mouse_x, mouse_y, btn_minus_x, btn_minus_y, btn_minus_x + sq_w, btn_minus_y + sq_h);
draw_set_color(_hover_minus ? c_yellow : c_white);
draw_rectangle(btn_minus_x, btn_minus_y, btn_minus_x + sq_w, btn_minus_y + sq_h, false);
draw_set_color(c_black);
draw_text(btn_minus_x + sq_w/2, btn_minus_y + sq_h/2, "-");

// Valor
draw_set_color(c_white);
draw_rectangle(val_x, val_y, val_x + val_w, val_y + val_h, false);
draw_set_color(c_black);
draw_text(val_x + val_w/2, val_y + val_h/2, string(global.laps_required));

// Botón "+"
var _hover_plus = point_in_rectangle(mouse_x, mouse_y, btn_plus_x, btn_plus_y, btn_plus_x + sq_w, btn_plus_y + sq_h);
draw_set_color(_hover_plus ? c_yellow : c_white);
draw_rectangle(btn_plus_x, btn_plus_y, btn_plus_x + sq_w, btn_plus_y + sq_h, false);
draw_set_color(c_black);
draw_text(btn_plus_x + sq_w/2, btn_plus_y + sq_h/2, "+");


// ------------------------------------------
// 2. BOTÓN CONFIGURAR IA (NUEVO)
// ------------------------------------------
var _hover_nn = point_in_rectangle(mouse_x, mouse_y, btn_nn_x, btn_nn_y, btn_nn_x + btn_nn_w, btn_nn_y + btn_nn_h);
draw_set_color(_hover_nn ? c_yellow : c_white);
draw_rectangle(btn_nn_x, btn_nn_y, btn_nn_x + btn_nn_w, btn_nn_y + btn_nn_h, false);
draw_set_color(c_black);
draw_text(btn_nn_x + btn_nn_w/2, btn_nn_y + btn_nn_h/2, "NN Config");


// ------------------------------------------
// 3. BOTÓN SALIR
// ------------------------------------------
var _hover_back = point_in_rectangle(mouse_x, mouse_y, btn_back_x, btn_back_y, btn_back_x + btn_back_w, btn_back_y + btn_back_h);
draw_set_color(_hover_back ? c_yellow : c_white);
draw_rectangle(btn_back_x, btn_back_y, btn_back_x + btn_back_w, btn_back_y + btn_back_h, false);
draw_set_color(c_black);
draw_text(btn_back_x + btn_back_w/2, btn_back_y + btn_back_h / 2, "Salir a menu principal");