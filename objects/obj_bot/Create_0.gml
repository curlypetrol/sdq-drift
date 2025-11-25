// Heredar padre
event_inherited();

// Config bot
is_bot = true;
stuck_counter = 0;
_thresh = 0.5;

// Silenciar motor
if (audio_is_playing(engine_sound_inst)) {
    audio_stop_sound(engine_sound_inst);
    engine_sound_inst = noone;
}

// Red neuronal
neural_network = instance_create_layer(x, y, "Instances", obj_neural_network);

// Visualizador debug
nn_viewer = instance_create_layer(x, y, "Instances", obj_nn_graph);
nn_viewer.network_ref = neural_network;
nn_viewer.visible = false;

log_stats = false; 

// Mascara de color
hue_shift = noone // El color se da al crear el objeto en el algoritmo genetico


// Variables fitness
start_x = x;
start_y = y;
distance_traveled = 0;
time_alive = 0;
fitness = 0;

// Variables para Debug en GUI
last_inputs = array_create(11, 0); // Guardará lo que vieron los sensores
last_outputs = [0, 0];             // Guardará qué decidió la red

// Config sensores
sensor_range = global.nn_config.sensor_range;
show_debug_rays = false;

// Funcion para cambiar el color del auto
function change_hue_shift(_hue) {
	hue_shift = _hue
	image_blend = make_color_hsv(hue_shift, 200, 255);
}


// Función raycast
function cast_ray(_angle_offset, _obj_check, _is_tile_check) {
    var _rad = degtorad(facing + _angle_offset);
    var _dx = cos(_rad);
    var _dy = -sin(_rad);
    
    var _check_dist = 0;
    var _step = 16;
    
    while (_check_dist < sensor_range) {
        var _cx = x + (_dx * _check_dist);
        var _cy = y + (_dy * _check_dist);
        var _hit = false;
        
        // Chequeo terreno
        if (_is_tile_check) {
            if (tile_terrain(_cx, _cy) == "offroad") _hit = true;
        } 
        // Chequeo objetos
        else {
            if (position_meeting(_cx, _cy, _obj_check)) _hit = true;
        }
        
        if (_hit) {
            // Retornar normalizado (1=cerca, 0=lejos)
            return 1.0 - (_check_dist / sensor_range);
        }
        
        _check_dist += _step;
    }
    
    return 0.0;
}

// Matriz de sensores
function get_sensor_matrix() {
    var _s = array_create(11, 0); 

    // Helper function para verificar config rápidamente
    var _check = function(_idx) {
        var _k = "x" + string(_idx);
        // Si existe y es false, devuelve false. Si no existe, true.
        if (variable_struct_exists(global.nn_config, _k)) return global.nn_config[$ _k];
        return true;
    };

    // Solo ejecutamos cast_ray si el sensor correspondiente (_check) es verdadero
    
    // 1. Mortal (x1)
    if (_check(1)) _s[0] = max(cast_ray(0, obj_Block, false), cast_ray(0, obj_Rock, false));
    
    // 2. Aceite (x2)
    if (_check(2)) _s[1] = cast_ray(0, obj_Oil, false);
    
    // 3, 4, 5. Boosts (x3, x4, x5)
    if (_check(3)) _s[2] = cast_ray(0, obj_Boost, false);
    if (_check(4)) _s[3] = cast_ray(30, obj_Boost, false);  
    if (_check(5)) _s[4] = cast_ray(-30, obj_Boost, false); 
    
    // 6, 7, 8. Offroad (x6, x7, x8)
    if (_check(6)) _s[5] = cast_ray(0, noone, true);        
    if (_check(7)) _s[6] = cast_ray(45, noone, true);       
    if (_check(8)) _s[7] = cast_ray(-45, noone, true);      
    
    // 9, 10, 11. Pared Segura (x9, x10, x11)
    if (_check(9))  _s[8] = cast_ray(0, obj_wall, false);    
    if (_check(10)) _s[9] = cast_ray(45, obj_wall, false);   
    if (_check(11)) _s[10] = cast_ray(-45, obj_wall, false); 

    // --- FILTRADO PARA LA RED (Igual que como lo arreglamos antes) ---
    var _matrix = [];
    for(var i = 0; i < 11; i++) {
        if (_check(i+1)) {
            array_push(_matrix, [_s[i]]);
        }
    }
    
    if (array_length(_matrix) == 0) return [[0]];
    
    return _matrix;
}