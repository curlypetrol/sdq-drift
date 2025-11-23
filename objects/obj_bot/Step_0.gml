// Chequeo muerte
if (state == PlayerState.DEAD) {
    event_inherited(); 
    exit;
}

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

var _val_left = _outputs[0][0];  
var _val_right = _outputs[1][0]; 
var _thresh = 0.5;

// Controlar inputs
ai_left = (_val_left > _thresh);
ai_right = (_val_right > _thresh);

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