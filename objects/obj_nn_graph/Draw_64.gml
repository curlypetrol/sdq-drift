if(no_input) exit;

neurons_pos = array_create(0)

// Poner capa INPUTS (h0)
array_push(neurons_pos, input_layer_pos)
draw_neurons(hidden_x[$ "h0"], miny, maxy, array_length(input_layer_pos), 100, 10, true);

// Poner capa OCULTA (h1) y SALIDA (h2)
// Usamos tu lógica de bucle, pero forzamos que h2 sea 'outputs' del config
var _h1_count = global.nn_config[$ "h1"]; // Cantidad neuronas ocultas
var _h2_count = global.nn_config[$ "outputs"]; // Cantidad salidas (2)

// Dibujamos h1
var _pos_h1 = draw_neurons(hidden_x[$ "h1"], miny, maxy, _h1_count, 100, 15, false);
array_push(neurons_pos, _pos_h1);

// Dibujamos h2 (Salida)
var _pos_h2 = draw_neurons(hidden_x[$ "h2"], miny, maxy, _h2_count, 100, 20, true);
array_push(neurons_pos, _pos_h2);


// Dibujar conexiones
// Iteramos sobre las capas guardadas en neurons_pos
for (var _i = 0; _i < array_length(neurons_pos) - 1; _i++)
{
    var _layer1 = neurons_pos[_i];
    if (array_length(_layer1) == 0) continue;

    // Search for next non-empty layer (Tu logica exacta)
    var _next_index = -1;
    for (var _j = _i + 1; _j < array_length(neurons_pos); _j++)
    {
        if (array_length(neurons_pos[_j]) > 0)
        {
            _next_index = _j;
            break;
        }
    }

    if (_next_index == -1) continue; // No forward layer found

    var _x1 = hidden_x[$ ("h" + string(_i))];       // ej: h0
    var _x2 = hidden_x[$ ("h" + string(_next_index))]; // ej: h1
    var _layer2 = neurons_pos[_next_index];
    var _s2 = array_length(_layer2);

    // Intentamos obtener los pesos reales de la red para colorear
    var _weights = undefined;
    if (instance_exists(network_ref) && _i < array_length(network_ref.net.weights)) {
        _weights = network_ref.net.weights[_i];
    }

    // Dibujar líneas
    for (var _j = 0; _j < array_length(_layer1); _j++)
    {
        // Input filter mask check (del ejemplo)
        if (_i == 0 && variable_struct_exists(global.nn_config, "x"+string(_j+1))) {
             if (!global.nn_config[$ ("x" + string(_j + 1))]) continue;
        }

        for (var _k = 0; _k < _s2; _k++)
        {
            var _width = 1;
            var _col = c_white;
            var _alpha = 0.3;

            // Si tenemos pesos, usamos color
            if (!is_undefined(_weights)) {
                 // Matriz es [Destino][Origen] -> [_k][_j]
                 var _w_val = _weights[_k][_j];
                 _width = min(4, abs(_w_val) * 2);
                 _col = (_w_val > 0) ? c_lime : c_red;
                 _alpha = min(1, abs(_w_val));
            }
            
            draw_set_alpha(_alpha);
            draw_line_width_color(_x1, _layer1[_j], _x2, _layer2[_k], _width, _col, _col);
            draw_set_alpha(1);
        }
    }
}