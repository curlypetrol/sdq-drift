// Heredar
event_inherited();

// Panel Debug
if (log_stats && global.show_debug_rays) {
    
    var _xx = display_get_gui_width() - 200; 
    var _yy = 20;
    var _lh = 18; 
    
    // Fondo
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(_xx - 10, _yy - 10, display_get_gui_width() - 10, _yy + 380, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    // Título
    draw_set_halign(fa_left);
    draw_text(_xx, _yy, "-- CEREBRO IA --"); _yy += _lh * 1.5;
    
    // Outputs
    draw_set_color(c_aqua);
    draw_text(_xx, _yy, "OUTPUTS:"); _yy += _lh;
    draw_set_color(c_white);
    
    var _str_l = string_format(last_outputs[0], 0, 2);
    if (last_outputs[0] > 0.5) draw_set_color(c_lime); 
    draw_text(_xx, _yy, "Turn Left : " + _str_l); _yy += _lh;
    draw_set_color(c_white);
    
    var _str_r = string_format(last_outputs[1], 0, 2);
    if (last_outputs[1] > 0.5) draw_set_color(c_lime); 
    draw_text(_xx, _yy, "Turn Right: " + _str_r); _yy += _lh * 1.5;
    draw_set_color(c_white);

    // Inputs
    draw_set_color(c_yellow);
    draw_text(_xx, _yy, "INPUTS (1=Cerca):"); _yy += _lh;
    draw_set_color(c_white);

    // Obstáculo mortal (Index 0)
    var _val_danger = last_inputs[0];
    var _c_danger = c_white;
    if (_val_danger > 0.1) _c_danger = c_orange;
    if (_val_danger > 0.7) _c_danger = c_red; 
    
    draw_set_color(_c_danger);
    draw_text(_xx, _yy, "Danger Obs: " + string_format(_val_danger, 0, 2)); 
    _yy += _lh;

    // Aceite (Index 1)
    var _val_oil = last_inputs[1];
    draw_set_color(_val_oil > 0 ? c_purple : c_gray);
    draw_text(_xx, _yy, "Oil Front   : " + string_format(_val_oil, 0, 2)); 
    _yy += _lh * 1.5; 

    // Boosts (Indices 2-4)
    var _b_active = (last_inputs[2] + last_inputs[3] + last_inputs[4] > 0);
    draw_set_color(_b_active ? c_lime : c_gray);
    
    draw_text(_xx, _yy, "Boosts:"); 
    _yy += _lh;
    var _bst_str = "F:" + string_format(last_inputs[2], 0, 1) + 
                   " L:" + string_format(last_inputs[3], 0, 1) + 
                   " R:" + string_format(last_inputs[4], 0, 1);
    draw_text(_xx, _yy, _bst_str);
    _yy += _lh * 1.5;

    // Offroad (Indices 5-7)
    var _off_active = (last_inputs[5] + last_inputs[6] + last_inputs[7] > 0);
    draw_set_color(_off_active ? c_orange : c_ltgray);
    
    draw_text(_xx, _yy, "Offroad:");
    _yy += _lh;
    var _off_str = "F:" + string_format(last_inputs[5], 0, 1) + 
                   " L:" + string_format(last_inputs[6], 0, 1) + 
                   " R:" + string_format(last_inputs[7], 0, 1);
    draw_text(_xx, _yy, _off_str);
    _yy += _lh * 1.5;

    // Pared segura (Indices 8-10)
    var _w_active = (last_inputs[8] + last_inputs[9] + last_inputs[10] > 0);
    draw_set_color(_w_active ? c_aqua : c_dkgray); 
    
    draw_text(_xx, _yy, "Wall:");
    _yy += _lh;
    var _wall_str = "F:" + string_format(last_inputs[8], 0, 1) + 
                    " L:" + string_format(last_inputs[9], 0, 1) + 
                    " R:" + string_format(last_inputs[10], 0, 1);
    draw_text(_xx, _yy, _wall_str);
    
    // Reset color
    draw_set_color(c_white);
}