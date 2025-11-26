// Función auxiliar
function draw_neurons(_x, _y1, _y2, _n, _d_max, _radius, _filled)
{
    if (_n <= 0) return [];
    var _dir = sign(_y2 - _y1);
    var _total_height = abs(_y2 - _y1);
    var _spacing = 0;
    var _circles_pos = array_create(0)

    if (_n == 1) {
        var _y = (_y1 + _y2) * 0.5;
        draw_circle(_x, _y, _radius, !_filled);
        array_push(_circles_pos, _y)
        return _circles_pos;
    }

    _spacing = _total_height / (_n - 1);
    if (_spacing > _d_max) {
        _spacing = _d_max;
        _total_height = _spacing * (_n - 1);
    }

    var _start_y = (_y1 + _y2) * 0.5 - _dir * (_total_height * 0.5);
    for (var _i = 0; _i < _n; _i++) {
        var _y = _start_y + _dir * _i * _spacing;
        draw_circle(_x, _y, _radius, !_filled);
        array_push(_circles_pos, _y)
    }
    return _circles_pos;
}

// Variables
neurons_pos = array_create(0);
no_input = false;
network_ref = noone;
var _inputs_count = 11; 

// Configuración visual
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (room == rm_nn_config) {
    // Modo Menú
    minx = 380; 
    maxx = room_width - 50; 
    miny = 340; 
    maxy = room_height - 50;
    
} else {
    // Modo Juego (Centrado)
    var _width_panel = _gui_w * 0.6;
    minx = (_gui_w / 2) - (_width_panel / 2);
    maxx = (_gui_w / 2) + (_width_panel / 2);
    
    miny = _gui_h * 0.5; 
    maxy = _gui_h - 50;
}

// Posiciones Inputs
input_layer_pos = array_create(0);
var _h = maxy - miny;
var _sep = (_inputs_count > 1) ? _h / (_inputs_count - 1) : 0;

for(var _i = 0; _i < _inputs_count; _i++){
    array_push(input_layer_pos, miny + (_i * _sep));
}

// Diccionario base
hidden_x = {
    "h0": minx, 
    "h1": minx + ((maxx - minx) / 2), 
    "h2": maxx,
    "h3": maxx + 100,
    "h4": maxx + 200
};