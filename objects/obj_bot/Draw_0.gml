draw_self(); // Dibuja el sprite del coche

// Dibujar corona si es el Elite
if (variable_instance_exists(id, "crown") && crown.visible) {
    draw_sprite(spr_crown, 0, x, y - 20);
}

// Dibujar Rayos de los Sensores (Debug)
if (show_debug_rays) {
    // Colores para identificar grupos: Rojo(Muerte), Morado(Aceite), Verde(Boost), Amarillo(Offroad)
    var _colors = [c_red, c_red, c_red, c_purple, c_lime, c_lime, c_lime, c_yellow, c_yellow, c_yellow];
    
    // Ángulos correspondientes a get_sensor_matrix
    var _angles = [0, 45, -45, 0, 0, 30, -30, 0, 90, -90];
    
    for (var i = 0; i < 10; i++) {
        var _rad = degtorad(facing + _angles[i]);
        var _len = sensor_range;
        
        draw_set_color(_colors[i]);
        draw_line(x, y, x + cos(_rad)*_len, y - sin(_rad)*_len);
    }
    draw_set_color(c_white);
}