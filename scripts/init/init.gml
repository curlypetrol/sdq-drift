
global.ASPHALT_MIN = 1;
global.ASPHALT_MAX = 10;
global.OFFROAD_MIN = 11;
global.OFFROAD_MAX = 20;

/// Estados del jugador
enum PlayerState { NORMAL, OIL, BOOST, DEAD, STOPPED };

/// Devuelve true si si hay un tile en un pixel especíco, sirve para detectar el tipo de terreno en un area
function tile_on_layer_at(layer_name, xp, yp) {
    if (!layer_exists(layer_name)) return false;

    var layer_id = layer_get_id(layer_name);
    var map_id   = layer_tilemap_get_id(layer_id);
    if (map_id < 0) return false; // no es Tile Layer

    var t = tilemap_get_at_pixel(map_id, xp, yp);
    return (t != 0); // 0 = sin tile
}

/// Devuelve los dos tipos de terrenos
function tile_terrain(xp, yp) {

    if (tile_on_layer_at("Tiles_Asphalt", xp, yp)) {
        return "asphalt";
    }
    if (tile_on_layer_at("Tiles_Offroad", xp, yp)) {
        return "offroad";
    }
    return "offroad";
}

// Calcular fps
function sec_to_steps(s) { 
	return ceil(s * game_get_speed(gamespeed_fps)); 
}


/// Mata al jugador
function player_die(p) {
    if (!instance_exists(p)) return;
    if (p.state == PlayerState.DEAD) return;
    p.state = PlayerState.DEAD;
    p.vx = 0; p.vy = 0;
    // reinicio
    p.alarm[0] = sec_to_steps(1);
}

// Convierte los milisegundos a formato de carrera
function time_format_ms(ms) {
    if (ms < 0) ms = 0;
    var total_sec = ms div 1000;
    var mm = total_sec div 60;
    var ss = total_sec mod 60;
    var cc = (ms mod 1000) div 10; // 0..99
    return string_format(mm, 2, 0) + ":" + string_format(ss, 2, 0) + ":" + string_format(cc, 2, 0);
}

// Para saber en qué lado de la meta está el jugador
function side_sign(x0, y0, nx, ny, px, py) {
    var vx = px - x0;
    var vy = py - y0;
    var d  = vx * nx + vy * ny; 
    return (d > 0) - (d < 0);  
}

global.nn_config = {
    // Inputs (Máscaras para dibujar debug, todos true para empezar)
    "x1": true, "x2": true, "x3": true, "x4": true, "x5": true,
    "x6": true, "x7": true, "x8": true, "x9": true, "x10": true,
    
    "inputs": 10,   // 10 Sensores
    "h1": 8,        // 8 Neuronas capa oculta
    "outputs": 2,   // 2 Salidas (Izquierda, Derecha)
    
    "n": 5,        // Población
    "mut": 60,     // Probabilidad mutación (10%)
    "select": 50,  // Porcentaje selección
    "sensor_range": 400 // Rango de visión
};

global.aspect_ratio = display_get_gui_width() / display_get_gui_height();
global.show_debug_rays = false;
global.debug = true;