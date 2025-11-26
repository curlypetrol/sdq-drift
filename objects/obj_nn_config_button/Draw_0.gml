draw_set_font(-1);
draw_set_valign(fa_middle);

// Título
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(room_width/2, 20, "CONFIGURACION IA");

// ============================================================
// COLUMNA 1: SENSORES
// ============================================================
draw_set_halign(fa_left);
var _col1_x = padding_x;
var _curr_y = padding_y;

draw_set_color(c_aqua);
draw_text(_col1_x, _curr_y - 25, "SENSORES:");

for (var i = 0; i < array_length(sensors); i++) {
    var _s = sensors[i];
    if (!variable_struct_exists(global.nn_config, _s.key)) global.nn_config[$ _s.key] = true;
    var _is_active = global.nn_config[$ _s.key];
    
    var _box_size = 25;
    var _bx = _col1_x;
    var _by = _curr_y - _box_size/2;
    
    // Checkbox
    draw_set_color(_is_active ? c_lime : c_red);
    draw_rectangle(_bx, _by, _bx + _box_size, _by + _box_size, false);
    
    // Texto
    draw_set_color(c_white);
    draw_text(_bx + 35, _curr_y, _s.label);
    
    _curr_y += line_height;
}

// ============================================================
// CONFIGURACIÓN (NN y Genética)
// ============================================================
var _top_y_start = padding_y; 

// --- COLUMNA 2: RED NEURONAL ---
var _col2_x = 400; 
_curr_y = _top_y_start;

draw_set_color(c_yellow);
draw_text(_col2_x, _curr_y - 25, "CAPAS OCULTAS:");

for (var i = 0; i < array_length(layers_conf); i++) {
    var _l = layers_conf[i];
    if (!variable_struct_exists(global.nn_config, _l.key)) global.nn_config[$ _l.key] = 0;
    var _count = global.nn_config[$ _l.key];
    
    draw_set_color(c_white);
    draw_text(_col2_x, _curr_y, _l.label);
    
    // Controles
    var _btn_size = 30;
    var _controls_x = _col2_x + 180;
    
    // Botón Menos
    draw_set_color(c_white);
    draw_rectangle(_controls_x, _curr_y - 15, _controls_x + _btn_size, _curr_y + 15, false);
    draw_set_color(c_black); draw_set_halign(fa_center);
    draw_text(_controls_x + _btn_size/2, _curr_y, "-");
    
    // Valor
    draw_set_color(c_white);
    draw_text(_controls_x + _btn_size + 25, _curr_y, string(_count));
    
    // Botón Más
    var _plus_x = _controls_x + _btn_size + 50;
    draw_set_color(c_white);
    draw_rectangle(_plus_x, _curr_y - 15, _plus_x + _btn_size, _curr_y + 15, false);
    draw_set_color(c_black);
    draw_text(_plus_x + _btn_size/2, _curr_y, "+");
    
    draw_set_halign(fa_left);
    _curr_y += line_height;
}

// --- COLUMNA 3: GENÉTICA ---
var _col3_x = 850; 
_curr_y = _top_y_start; 

draw_set_color(c_orange);
draw_text(_col3_x, _curr_y - 25, "ALGORITMO GENETICO:");

for (var i = 0; i < array_length(ga_conf); i++) {
    var _g = ga_conf[i];
    if (!variable_struct_exists(global.ga_config, _g.key)) global.ga_config[$ _g.key] = _g.min;
    var _val = global.ga_config[$ _g.key];
    
    draw_set_color(c_white);
    draw_text(_col3_x, _curr_y, _g.label);
    
    // Controles
    var _btn_size = 30;
    var _controls_x = _col3_x + 160;
    
    // Botón Menos
    draw_set_color(c_white);
    draw_rectangle(_controls_x, _curr_y - 15, _controls_x + _btn_size, _curr_y + 15, false);
    draw_set_color(c_black); draw_set_halign(fa_center);
    draw_text(_controls_x + _btn_size/2, _curr_y, "-");
    
    // Valor
    draw_set_color(c_white);
    draw_text(_controls_x + _btn_size + 25, _curr_y, string(_val));
    
    // Botón Más
    var _plus_x = _controls_x + _btn_size + 50;
    draw_set_color(c_white);
    draw_rectangle(_plus_x, _curr_y - 15, _plus_x + _btn_size, _curr_y + 15, false);
    draw_set_color(c_black);
    draw_text(_plus_x + _btn_size/2, _curr_y, "+");
    
    draw_set_halign(fa_left);
    _curr_y += line_height;
}

// BOTÓN VOLVER
var _mx = mouse_x; var _my = mouse_y;
var _hover = point_in_rectangle(_mx, _my, btn_back_rect[0], btn_back_rect[1], btn_back_rect[2], btn_back_rect[3]);
draw_set_color(_hover ? c_yellow : c_white);
draw_rectangle(btn_back_rect[0], btn_back_rect[1], btn_back_rect[2], btn_back_rect[3], false);
draw_set_color(c_black); draw_set_halign(fa_center);
draw_text((btn_back_rect[0] + btn_back_rect[2])/2, (btn_back_rect[1] + btn_back_rect[3])/2, "VOLVER");