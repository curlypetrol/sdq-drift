
global.ASPHALT_MIN = 1;
global.ASPHALT_MAX = 10;
global.OFFROAD_MIN = 11;
global.OFFROAD_MAX = 20;

global.custom_gene = { biases : [ [ [ -0.80 ],[ -0.11 ],[ -0.79 ],[ 0.67 ],[ 0.00 ],[ 0.29 ],[ -0.82 ],[ -0.81 ] ],[ [ -0.98 ],[ 0.80 ],[ -0.40 ],[ -0.11 ] ],[ [ 0.89 ],[ -0.22 ],[ -0.95 ],[ 0.69 ],[ 0.87 ],[ 0.58 ] ],[ [ 1.00 ],[ 1 ] ],[ [ -0.77 ],[ -0.31 ] ] ], 
	weights : [ [ 
	[ 0.76,0.35,-0.04,-0.61,0.58,0.08,-0.60,-0.29,1,0.83,-0.87 ],
	[ -0.46,0.97,-0.31,1,1,0.58,0.49,0.16,-0.23,0.03,0.66 ],
	[ -0.50,-0.05,-0.51,0.14,0.96,0.15,0.01,-0.38,-0.74,-0.25,-0.04 ],
	[ -0.08,0.30,-0.20,0.46,-0.49,0.90,-0.74,0.85,0.15,0.18,0.63 ],
	[ -0.75,0.76,-0.42,0.19,0.46,1,-0.75,0.23,-0.21,0.02,-0.47 ],
	[ -1,-0.05,-0.23,0.50,0.13,0.81,-0.62,0.06,-0.85,1.00,-0.52 ],
	[ -0.46,0.05,0.06,0.45,0.89,0.76,0.70,-0.12,-0.41,0.61,0.15 ],
	[ 0.37,-0.48,-0.18,0.68,-0.45,0.27,-0.50,0.84,-0.97,0.67,0.58 ] ],
	[ 
	[ 0.45,-0.29,0.18,-0.18,0.64,-0.41,0.23,-0.83 ],
	[ 0.43,-0.55,-0.01,0.25,0.14,0.90,-0.88,0.71 ],
	[ -0.73,-0.10,-0.25,0.71,-0.88,0.44,1,0.02 ],
	[ 0.61,-0.07,-0.52,-0.99,0.19,0.76,0.41,0.10 ] 
	]
	,[ [ 0.15,0.01,0.69,-0.06 ],[ -0.14,0.06,0.03,1 ],[ 0.03,0.00,0.74,0.25 ],[ -0.22,-0.80,0.16,0.01 ],[ 0.37,0.34,0.98,-0.90 ],[ 0.33,0.11,-1.00,-0.54 ] ],[ [ -0.91,0.82,-0.41,-0.24,-0.64,-0.41 ],[ 0.92,0.94,-0.12,-0.76,-0.79,0.35 ] ],[ [ 0.38,-0.17 ],[ 0.24,0.38 ] ] ], hue : 81.41};

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
	"x11": true,
    
    "inputs": 10,   // 10 Sensores
    "h1": 8,        // 8 Neuronas capa oculta
    "h2": 4,
	"h3": 6,
	"h4": 2,
	"outputs": 2,   // 2 Salidas (Izquierda, Derecha)
	"sensor_range": 400 // Rango de visión
};

global.ga_config = {
	
	"n": 10,        // Población
    "mut": 20,     // Probabilidad mutación (10%)
    "select": 60,  // Porcentaje selección
	"time_alive": 5 // Segundos para matar un poblador si se atasca
};

global.aspect_ratio = display_get_gui_width() / display_get_gui_height();

global.debug = true;

global.aspect_ratio = display_get_gui_width() / display_get_gui_height();
global.show_debug_rays = false;
global.debug = true;