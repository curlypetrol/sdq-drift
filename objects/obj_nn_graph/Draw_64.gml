// Seguridad debug
if (room != rm_nn_config && (!variable_global_exists("show_debug_rays") || !global.show_debug_rays)) exit;
if (no_input) exit;

// 1. Estructura de capas
var _layers_struct = [];

// Inputs
array_push(_layers_struct, { name: "Inputs", count: array_length(input_layer_pos), is_input: true });

// Capas ocultas (h1-h4)
var _hidden_keys = ["h1", "h2", "h3", "h4"];
for (var i = 0; i < array_length(_hidden_keys); i++) {
    var _k = _hidden_keys[i];
    
    if (variable_struct_exists(global.nn_config, _k)) {
        var _count = global.nn_config[$ _k];
        if (_count > 0) {
            array_push(_layers_struct, { name: _k, count: _count, is_input: false });
        }
    }
}

// Salida
var _out_count = 2; 
if (variable_struct_exists(global.nn_config, "outputs")) _out_count = global.nn_config[$ "outputs"];
array_push(_layers_struct, { name: "Output", count: _out_count, is_input: false });


// 2. Dibujar nodos
neurons_pos = []; 
var _total_layers = array_length(_layers_struct);
var _total_width = maxx - minx;

for (var i = 0; i < _total_layers; i++) {
    
    // Calcular X
    var _x = minx;
    if (_total_layers > 1) {
        _x = minx + (i * (_total_width / (_total_layers - 1)));
    }
    
    var _layer_data = _layers_struct[i];
    var _pos_y_array = [];

    // Inputs (Filtrar activos)
    if (_layer_data.is_input) {
        for (var k = 0; k < array_length(input_layer_pos); k++) {
            
            var _active = true;
            var _key = "x" + string(k + 1);
            if (variable_struct_exists(global.nn_config, _key)) _active = global.nn_config[$ _key];
            
            if (_active) {
                draw_circle(_x, input_layer_pos[k], 10, false); 
                array_push(_pos_y_array, input_layer_pos[k]);
            }
        }
    } 
    // Ocultas / Salida
    else {
        var _is_last = (i == _total_layers - 1);
        var _radius = _is_last ? 20 : 15; 
        
        _pos_y_array = draw_neurons(_x, miny, maxy, _layer_data.count, 100, _radius, !_is_last);
    }
    
    array_push(neurons_pos, _pos_y_array);
}


// 3. Conexiones (Pesos)
for (var _i = 0; _i < array_length(neurons_pos) - 1; _i++)
{
    var _layer1 = neurons_pos[_i];      
    var _layer2 = neurons_pos[_i + 1]; 
    
    if (array_length(_layer1) == 0 || array_length(_layer2) == 0) continue;

    // Obtener pesos
    var _weights = undefined;
    if (instance_exists(network_ref) && _i < array_length(network_ref.net.weights)) {
        _weights = network_ref.net.weights[_i];
    }

    // Recalcular X
    var _x1 = minx; 
    if (_total_layers > 1) _x1 = minx + (_i * (_total_width / (_total_layers - 1)));
    
    var _x2 = minx; 
    if (_total_layers > 1) _x2 = minx + ((_i + 1) * (_total_width / (_total_layers - 1)));

    var _weight_col_index = 0; 

    // Bucle origen
    for (var _j = 0; _j < array_length(_layer1); _j++)
    {
        // Bucle destino
        var _s2 = array_length(_layer2);
        for (var _k = 0; _k < _s2; _k++)
        {
            var _width = 1;
            var _col = c_white;
            var _alpha = 0.2; 

            if (!is_undefined(_weights)) {
                // Validar rangos
                if (_k < array_length(_weights) && _weight_col_index < array_length(_weights[_k])) {
                    
                    var _w_val = _weights[_k][_weight_col_index];
                    
                    _width = min(5, abs(_w_val) * 2);
                    _col = (_w_val > 0) ? c_lime : c_red;
                    _alpha = min(1, abs(_w_val));
                    
                    // Ocultar líneas débiles
                    if (abs(_w_val) < 0.1) _alpha = 0; 
                }
            }
            
            if (_alpha > 0) {
                draw_set_alpha(_alpha);
                draw_line_width_color(_x1, _layer1[_j], _x2, _layer2[_k], _width, _col, _col);
                draw_set_alpha(1);
            }
        }
        _weight_col_index++;
    }
}