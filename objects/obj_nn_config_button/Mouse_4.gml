var _mx = mouse_x;
var _my = mouse_y;
var _top_y_start = padding_y;
var _btn_size = 30;

// 1. SENSORES (Izquierda)
var _col1_x = padding_x;
var _curr_y = _top_y_start;

for (var i = 0; i < array_length(sensors); i++) {
    if (point_in_rectangle(_mx, _my, _col1_x, _curr_y - 15, _col1_x + 300, _curr_y + 15)) {
        var _key = sensors[i].key;
        global.nn_config[$ _key] = !global.nn_config[$ _key];
    }
    _curr_y += line_height;
}

// 2. RED NEURONAL (Centro)
var _col2_x = 400; 
_curr_y = _top_y_start;

for (var i = 0; i < array_length(layers_conf); i++) {
    var _key = layers_conf[i].key;
    var _controls_x = _col2_x + 180;
    
    // [-]
    if (point_in_rectangle(_mx, _my, _controls_x, _curr_y - 15, _controls_x + _btn_size, _curr_y + 15)) {
        if (global.nn_config[$ _key] > 0) global.nn_config[$ _key]--;
    }
    // [+]
    var _plus_x = _controls_x + _btn_size + 50;
    if (point_in_rectangle(_mx, _my, _plus_x, _curr_y - 15, _plus_x + _btn_size, _curr_y + 15)) {
        if (global.nn_config[$ _key] < 20) global.nn_config[$ _key]++;
    }
    _curr_y += line_height;
}

// 3. GENÉTICA (Derecha)
var _col3_x = 850; 
_curr_y = _top_y_start; 

for (var i = 0; i < array_length(ga_conf); i++) {
    var _g = ga_conf[i];
    var _key = _g.key;
    var _controls_x = _col3_x + 160;
    
    // [-]
    if (point_in_rectangle(_mx, _my, _controls_x, _curr_y - 15, _controls_x + _btn_size, _curr_y + 15)) {
        var _new_val = global.ga_config[$ _key] - _g.step;
        global.ga_config[$ _key] = max(_g.min, _new_val);
    }
    // [+]
    var _plus_x = _controls_x + _btn_size + 50;
    if (point_in_rectangle(_mx, _my, _plus_x, _curr_y - 15, _plus_x + _btn_size, _curr_y + 15)) {
        var _new_val = global.ga_config[$ _key] + _g.step;
        global.ga_config[$ _key] = min(_g.max, _new_val);
    }
    _curr_y += line_height;
}

// 4. VOLVER
if (point_in_rectangle(_mx, _my, btn_back_rect[0], btn_back_rect[1], btn_back_rect[2], btn_back_rect[3])) {
    room_goto(rm_options); 
}