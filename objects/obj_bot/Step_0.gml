// Detectar si está atorado
var _speed = speed;

if (_speed < 0.1) stuck_counter++;
else stuck_counter = 0; 


if (state == PlayerState.STOPPED and stuck_counter >= room_speed * global.ga_config[$ "time_alive"]) {
    instance_destroy();
    exit;
}


// Chequeo muerte
if (state == PlayerState.DEAD) {
    event_inherited(); 
    exit;
}



// show_debug_message("\nRoom Speed" + string(room_speed))
// show_debug_message("Stuck Counter" + string(stuck_counter))


// Actualizar fitness
time_alive++;
var _dist_now = point_distance(start_x, start_y, x, y);
if (_dist_now > distance_traveled) {
    distance_traveled = _dist_now;
}
fitness = distance_traveled + (time_alive * 0.1);

// Proceso IA
var _inputs = get_sensor_matrix();
var _outputs = neural_network.evaluate_network_2(_inputs);

// Guardar datos para el DrawGUI
var _read_idx = 0;

for(var i = 0; i < 11; i++) {
    // 1. Verificamos si este sensor (x1, x2... x11) está activo en la configuración
    var _key = "x" + string(i + 1);
    var _is_active = true;
    
    // Si la llave existe en config, usamos su valor. Si no, asumimos true.
    if (variable_struct_exists(global.nn_config, _key)) {
        _is_active = global.nn_config[$ _key];
    }

    if (_is_active) {
        // Si está activo, leemos el siguiente valor disponible de la matriz de la IA
        // Verificamos que no nos salgamos del array por seguridad
        if (_read_idx < array_length(_inputs)) {
            last_inputs[i] = _inputs[_read_idx][0];
            _read_idx++; // Avanzamos al siguiente dato
        } else {
            last_inputs[i] = 0;
        }
    } else {
        // Si el sensor está apagado, mostramos 0 en el GUI
        last_inputs[i] = 0;
    }
}

last_outputs[0] = _outputs[0][0]; // Decisión Izquierda
last_outputs[1] = _outputs[1][0]; // Decisión Derecha

var _val_left = _outputs[0][0];  
var _val_right = _outputs[1][0]; 
var _thresh = 0.5;

// Controlar inputs
input_left = (_val_left > _thresh);
input_right = (_val_right > _thresh);

// Aplicar físicas
event_inherited();

// Visualizador debug
if (global.debug && log_stats) {
    nn_viewer.visible = true;
    nn_viewer.x = camera_get_view_x(view_camera[0]) + 20;
    nn_viewer.y = camera_get_view_y(view_camera[0]) + 150;
    show_debug_rays = true;
} else {
    nn_viewer.visible = false;
    show_debug_rays = false;
}