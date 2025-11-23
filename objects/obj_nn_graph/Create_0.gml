
function draw_neurons(_x, _y1, _y2, _n, _d_max, _radius, _filled)
{
    if (_n <= 0) return [];
    var _dir = sign(_y2 - _y1);
    var _total_height = abs(_y2 - _y1);
    var _spacing = 0;
    var _circles_pos = array_create(0)

    if (_n == 1)
    {
        var _y = (_y1 + _y2) * 0.5;
        draw_circle(_x, _y, _radius, !_filled);
        array_push(_circles_pos, _y)
        return _circles_pos;
    }

    _spacing = _total_height / (_n - 1);
    if (_spacing > _d_max)
    {
        _spacing = _d_max;
        _total_height = _spacing * (_n - 1);
    }

    var _start_y = (_y1 + _y2) * 0.5 - _dir * (_total_height * 0.5);
    for (var _i = 0; _i < _n; _i++)
    {
        var _y = _start_y + _dir * _i * _spacing;
        draw_circle(_x, _y, _radius, !_filled);
        array_push(_circles_pos, _y)
    }
    return _circles_pos;
}

// 2. Variables de configuración
neurons_pos = array_create(0)
no_input = false
network_ref = noone;

// Area de dibujo
miny = 258;
maxy = 650;
minx = 347;
maxx = 862;

// 3. Generar posiciones de los 10 INPUTS (h0)
input_layer_pos = array_create(0);
var _inputs_count = 10; 
var _h = maxy - miny;
var _sep = _h / (_inputs_count - 1);

for(var _i = 0; _i < _inputs_count; _i++){
    array_push(input_layer_pos, miny + (_i * _sep));
}

// 4. Definir posiciones X de las capas
// h0: Inputs, h1: Oculta, h2: Salida
hidden_x = {
    "h0": minx, 
    "h1": minx + ((maxx - minx) / 2), 
    "h2": maxx,
    "h3": maxx + 100, // Extra por si acaso
    "h4": maxx + 200
}