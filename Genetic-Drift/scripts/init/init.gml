
global.ASPHALT_MIN = 1;
global.ASPHALT_MAX = 10;
global.OFFROAD_MIN = 11;
global.OFFROAD_MAX = 20;

/// Estados del jugador
enum PlayerState { NORMAL, OIL, BOOST, DEAD };

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

/// Devuelve true si si hay un tile en un pixel especíco, sirve para detectar el tipo de terreno en un area
function tile_on_layer_at(layer_name, xp, yp) {
    if (!layer_exists(layer_name)) return false;

    var layer_id = layer_get_id(layer_name);
    var map_id   = layer_tilemap_get_id(layer_id);

    if (map_id < 0) return false;

    var t = tilemap_get_at_pixel(map_id, xp, yp);
    return (t != 0);
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
