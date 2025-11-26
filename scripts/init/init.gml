
global.ASPHALT_MIN = 1;
global.ASPHALT_MAX = 10;
global.OFFROAD_MIN = 11;
global.OFFROAD_MAX = 20;

global.custom_gene = {biases : [ [ [ 0.74 ],[ 1 ],[ 0.19 ],[ -0.05 ],[ -0.94 ],[ -1 ],[ 0.62 ],[ -0.37 ],[ 0.37 ],[ -0.71 ],[ -0.89 ],[ -1 ] ],[ [ 0.06 ],[ 0.05 ],[ 0.92 ],[ -0.40 ],[ -0.39 ],[ -1 ],[ 0.05 ],[ -1 ] ],[ [ 0.75 ],[ 0.57 ] ] ], weights : [ [ [ -0.50,-0.85,1 ],[ 0.33,0.94,-0.35 ],[ 1,-0.31,1 ],[ 1,-0.62,0.16 ],[ -0.55,-0.03,-0.42 ],[ -0.14,0.65,-0.44 ],[ -1,-0.73,1 ],[ -0.87,0.37,-1 ],[ -0.69,-0.44,-0.68 ],[ 0.23,-1,0.70 ],[ -1,-1,-1 ],[ -0.86,0.60,0.46 ] ],[ [ 0.94,-0.30,-0.91,-1,0.76,-1,-0.95,0.71,-0.83,0.42,-0.11,-0.66 ],[ 0.34,-0.58,1,0.40,0.77,-0.77,-0.30,-0.81,0.27,-0.53,-0.19,0.47 ],[ 1,0.63,-0.56,0.62,-1,1,0.37,0.62,1,1,0.37,0.61 ],[ 0.98,0.77,0.25,0.53,0.19,0.58,0.93,-1,0.28,0.35,0.37,0.25 ],[ -0.75,-0.44,0.36,0.50,0.40,1,-0.53,-0.68,-0.27,1,-0.78,0.90 ],[ -1,0.13,-0.43,-0.47,-0.29,-0.84,0.20,0.05,-0.74,-1,0.55,0.58 ],[ 0.40,1,-1,-1,-1,0.37,0.43,-0.16,-1,1,-0.99,-1 ],[ -0.93,1,-0.21,-0.31,-0.22,0.34,-0.64,0.42,0.98,0.98,-0.58,-1 ] ],[ [ 1,-0.39,-0.25,0.74,0.49,0.17,-1,-0.95 ],[ 1,-0.56,0.02,-0.14,1,1,-0.44,1 ] ] ], 
hue : 63.58, fitness : 3, best_dist : 0}
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
    "x1": false, "x2": false, "x3": false, "x4": false, "x5": false,
    "x6": false, "x7": false, "x8": false, "x9": true, "x10": true,
	"x11": true,
    
    "inputs": 10,   // 10 Sensores
    "h1": 12,        // 8 Neuronas capa oculta
    "h2": 8,
	"h3": 0,
	"h4": 0,
	"outputs": 2,   // 2 Salidas (Izquierda, Derecha)
	"sensor_range": 500 // Rango de visión
};

global.ga_config = {
	
	"n": 50,        // Población
    "mut": 40,     // Probabilidad mutación
    "select": 60,  // Porcentaje selección
	"time_alive": 2 // Segundos para matar un poblador si se atasca
};

global.aspect_ratio = display_get_gui_width() / display_get_gui_height();

global.debug = true;

global.aspect_ratio = display_get_gui_width() / display_get_gui_height();
global.show_debug_rays = false;
global.debug = true;