// Heredar padre
event_inherited(); 

// Configuración bot
is_bot = true;      
ai_left = false;    
ai_right = false;   

// Silenciar motor (activar solo si es elite)
if (audio_is_playing(engine_sound_inst)) {
    audio_stop_sound(engine_sound_inst);
    engine_sound_inst = noone; // Marcarlo como no existente
}

// Iniciar red neuronal
neural_network = instance_create_layer(x, y, "Instances", obj_neural_network);

// Iniciar visualizador
nn_viewer = instance_create_layer(x, y, "Instances", obj_nn_graph);
nn_viewer.network_ref = neural_network; 
nn_viewer.visible = false; 

log_stats = false;

// Variables fitness
start_x = x;
start_y = y;
distance_traveled = 0;
time_alive = 0;
fitness = 0;

// Configuración sensores
sensor_range = global.nn_config.sensor_range; 
show_debug_rays = false; 



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
        
        // Chequeo tile (offroad)
        if (_is_tile_check) {
            if (tile_terrain(_cx, _cy) == "offroad") _hit = true;
        } 
        // Chequeo objetos
        else {
            if (position_meeting(_cx, _cy, _obj_check)) _hit = true;
        }
        
        if (_hit) {
            // Retorna distancia normalizada (1=cerca, 0=lejos)
            return 1.0 - (_check_dist / sensor_range);
        }
        
        _check_dist += _step;
    }
    
    return 0.0; 
}

// Generar inputs
function get_sensor_matrix() {
    var _s = array_create(10, 0);
    
    // Obstáculos (Paredes/Rocas)
    _s[0] = max(cast_ray(0, obj_Block, false), cast_ray(0, obj_Rock, false));   
    _s[1] = max(cast_ray(45, obj_Block, false), cast_ray(45, obj_Rock, false)); 
    _s[2] = max(cast_ray(-45, obj_Block, false), cast_ray(-45, obj_Rock, false));
    
    // Trampas
    _s[3] = cast_ray(0, obj_Oil, false); 
    
    // Incentivos
    _s[4] = cast_ray(0, obj_Boost, false);   
    _s[5] = cast_ray(30, obj_Boost, false);  
    _s[6] = cast_ray(-30, obj_Boost, false); 
    
    // Terreno
    _s[7] = cast_ray(0, noone, true);   
    _s[8] = cast_ray(90, noone, true);  
    _s[9] = cast_ray(-90, noone, true); 
    
    // Formato matriz columna
    var _matrix = array_create(10);
    for(var i=0; i<10; i++) {
        _matrix[i] = [_s[i]];
    }
    return _matrix;
}

// Color aleatorio
hue_shift = irandom(255); 
image_blend = make_color_hsv(hue_shift, 200, 255);