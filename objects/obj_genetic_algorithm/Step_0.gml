var _default_depth = layer_get_depth("Instances"); 
var _size = ds_list_size(bots);

var _best_alive = noone;
var _max_alive_fitness = -1;

var _target_bot = noone;

// A) Si best_gene existe como instancia
if (instance_exists(best_gene)) {
    _target_bot = best_gene;
}
// B) Si no, seguimos al mejor bot vivo de esta generación
else {


	for (var i = 0; i < _size; i++) {
	    var _bot = bots[| i];

	    if (instance_exists(_bot)) {

	        _bot.image_blend = make_color_hsv(_bot.hue_shift, 200, 255);
	        _bot.depth = _default_depth;

	        if (_bot.fitness > _max_alive_fitness) {
	            _max_alive_fitness = _bot.fitness;
	            _best_alive = _bot;
	        }
	    }
	}
    _target_bot = _best_alive;
}

// 3. Si hay alguien que seguir…
if (instance_exists(_target_bot)) {

    // Píntalo blanco y ponlo al frente
    // _target_bot.image_blend = c_white;
    _target_bot.depth = _default_depth - 1000;

    // Cámara sigue al target
    if (instance_exists(obj_Camera)) {
        obj_Camera.target = _target_bot;
    }

    // Activar stats solo para el bot observado
    if (_target_bot.log_stats == false) {

        with (obj_bot) log_stats = false;

        _target_bot.log_stats = true;

        if (instance_exists(_target_bot.nn_viewer)) {
            _target_bot.nn_viewer.visible = true;
        }
    }
}