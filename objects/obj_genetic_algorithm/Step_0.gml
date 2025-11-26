
var _best_bot = noone;
var _max_fitness = -1;

var _default_depth = layer_get_depth("Instances"); 

var _size = ds_list_size(bots);

for (var i = 0; i < _size; i++) {
    var _bot = bots[| i];

    if (instance_exists(_bot)) {
        _bot.image_blend = make_color_hsv(_bot.hue_shift, 200, 255);
        _bot.depth = _default_depth;

        // B) COMPARACIÓN: ¿Es este el mejor hasta ahora?
        if (_bot.fitness > _max_fitness) {
            _max_fitness = _bot.fitness;
            _best_bot = _bot;
        }
    }
}

if (instance_exists(_best_bot)) {
    
    // A) Destacar visualmente (Blanco y encima de todos)
    _best_bot.image_blend = c_white; 
    _best_bot.depth = _default_depth - 1000; 
    
    // B) Asignar a la cámara
    if (instance_exists(obj_Camera)) {
        obj_Camera.target = _best_bot;
    }
    
    // C) Activar estadísticas y red neuronal
    if (_best_bot.log_stats == false) {
        with (obj_bot) { log_stats = false; }
        
        _best_bot.log_stats = true;
        
        if (instance_exists(_best_bot.nn_viewer)) {
             _best_bot.nn_viewer.visible = true;
        }
    }
}