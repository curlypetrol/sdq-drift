// Evento DRAW de obj_Bot

draw_self(); // Dibuja el coche

// Dibuja la corona si es el mejor (Elite)
if (variable_instance_exists(id, "crown") && instance_exists(crown) && crown.visible) {
    draw_sprite(spr_crown, 0, x, y - 40);
}

// Visualizacion de sensores
if (global.show_debug_rays && log_stats) {
    
    // Configuración visual
    var _sensor_range = 200; // Ajusta esto a la distancia real que usas en la lógica
    
    // Colores según tipo de sensor
    var _colors = [
        c_red, c_red, c_red,           // 1-3: Obstáculos (Pared/Roca)
        c_purple,                      // 4: Aceite
        c_lime, c_lime, c_lime,        // 5-7: Boosts
        c_yellow, c_yellow, c_yellow   // 8-10: Offroad
    ];
    
    // Angulos de lso sensores
    var _angles = [
        0,      // 1. Frontal Obstáculo
        45,     // 2. Lateral Izq Obstáculo 
        -45,    // 3. Lateral Der Obstáculo
        0,      // 4. Frontal Aceite
        0,      // 5. Frontal Boost
        30,     // 6. Lateral Izq Boost
        -30,    // 7. Lateral Der Boost
        0,      // 8. Frontal Offroad
        90,     // 9. Lateral Izq Offroad (90 grados exactos)
        -90     // 10. Lateral Der Offroad
    ];

    // 3. Dibujado optimizado
    draw_set_alpha(0.6); // Semitransparente para ver el juego debajo
    
    for (var i = 0; i < 10; i++) {
		
		var _key = "x" + string(i + 1);
        var _is_active = true;
        if (variable_struct_exists(global.nn_config, _key)) {
            _is_active = global.nn_config[$ _key];
        }

        if (!_is_active) continue;
		
        // Sumamos el ángulo del sensor a la rotación actual del coche (image_angle)
        var _final_angle = image_angle + _angles[i];
        
        // Calculamos el punto final usando lengthdir
        var _end_x = x + lengthdir_x(_sensor_range, _final_angle);
        var _end_y = y + lengthdir_y(_sensor_range, _final_angle);
        
        // Dibujamos la línea
        draw_line_width_color(x, y, _end_x, _end_y, 2, _colors[i], _colors[i]);
        
        // Opcional: Un pequeño punto en la punta ayuda a ver la profundidad
        draw_circle_color(_end_x, _end_y, 3, _colors[i], _colors[i], false);
    }
    
    draw_set_alpha(1); // Restaurar alfa
}