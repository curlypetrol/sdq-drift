
// 2. Lógica de "Cámara Espectador" (AGREGAR ESTO)
var _viewer_found = false;

// Revisamos si todavía existe algún bot reportando estadísticas
for (var i = 0; i < ds_list_size(bots); i++) {
    var _bot = bots[| i];
    // Si el bot existe y tiene el permiso de log_stats
    if (instance_exists(_bot) && _bot.log_stats) {
        _viewer_found = true;
        break; 
    }
}

// Si NO encontramos a nadie (el bot que mirábamos murió), asignamos uno nuevo
if (!_viewer_found) {
    for (var i = 0; i < ds_list_size(bots); i++) {
        var _next_bot = bots[| i];
        
        // Buscamos el primer bot que esté vivo en la lista
        if (instance_exists(_next_bot)) {
            _next_bot.log_stats = true; // ¡Tú eres el elegido ahora!
            
            // Si también quieres que se vea su red neuronal (obj_nn_graph), actívala:
            if (instance_exists(_next_bot.nn_viewer)) {
                _next_bot.nn_viewer.visible = true;
            }
            
            break; // Ya encontramos uno, dejamos de buscar
        }
    }
}