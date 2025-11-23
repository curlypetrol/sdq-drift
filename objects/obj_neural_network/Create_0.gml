// Estructura de la red
net = {
    weights: [],
    biases: [],
    activations: []    
};

// Inicializar red
function init_network(_layer_sizes) {
    // Limpiar arrays
    net.weights = [];
    net.biases = [];

    // Crear matrices de pesos
    for (var _i = 1; _i < array_length(_layer_sizes); _i++) {
        var _rows = _layer_sizes[_i];
        var _cols = _layer_sizes[_i - 1];
        
        var _w = create_random_matrix(_rows, _cols);
        var _b = create_random_matrix(_rows, 1);
        
        array_push(net.weights, _w);
        array_push(net.biases, _b);
    }
}

// Activación ReLU
function relu(_x_matrix) {
    return _matrix_map(_x_matrix, function(_v) { return max(0, _v); });
}

// Activación Sigmoide
function sigmoid(_x_matrix) {
    return _matrix_map(_x_matrix, function(_v) { return 1 / (1 + exp(-_v)); });
}

// Feed Forward
function evaluate_network_2(_input_vec, _hidden_act_fn=relu, _output_act_fn=sigmoid) {
    if (n_inputs == 0) return [[0]];
    
    var _a = _input_vec;
    
    // Calcular capas
    for (var _i = 0; _i < array_length(net.weights); _i++) {
        var _weighted_sum = _matrix_multiply(net.weights[_i], _a);
        var _z = _matrix_sum(_weighted_sum, net.biases[_i]);
        
        // Aplicar activación
        if (_i == array_length(net.weights) - 1) {
            _a = _output_act_fn(_z);
        } else {
            _a = _hidden_act_fn(_z);
        }
    }
    return _a;
}

// Obtener genes
function get_genes() {
    return { weights: net.weights, biases: net.biases };
}

// Asignar genes
function set_genes(_gene_struct) {
    net.weights = _gene_struct.weights;
    net.biases = _gene_struct.biases;
}

// Configurar salidas
n_outputs = 2; 

// Capas ocultas
var _global_hidden = [
    global.nn_config[$ "h1"],
    global.nn_config[$ "h2"],
    global.nn_config[$ "h3"],
    global.nn_config[$ "h4"]
];

// Definir inputs
mask_x = [
    global.nn_config[$ "x1"], global.nn_config[$ "x2"], global.nn_config[$ "x3"],
    global.nn_config[$ "x4"], global.nn_config[$ "x5"], global.nn_config[$ "x6"],
    global.nn_config[$ "x7"], global.nn_config[$ "x8"], global.nn_config[$ "x9"],
    global.nn_config[$ "x10"]
];

// Calcular inputs activos
var _active_inputs = array_filter_by_mask(mask_x, mask_x); 
n_inputs = array_length(_active_inputs);

// Validar inputs
if (n_inputs == 0) n_inputs = 10; 

// Filtrar capas vacías
var _active_hidden_layers = [];
for (var i = 0; i < array_length(_global_hidden); i++) {
    if (_global_hidden[i] > 0) array_push(_active_hidden_layers, _global_hidden[i]);
}

// Construir topología
layers = [];
array_push(layers, n_inputs);

for (var i = 0; i < array_length(_active_hidden_layers); i++) {
    array_push(layers, _active_hidden_layers[i]);
}

array_push(layers, n_outputs);

// Inicializar
init_network(layers);