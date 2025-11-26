
draw_self(); 

if (best_gene) {

    var _offset_dist = 16; 
    
    var _cx = x + lengthdir_x(_offset_dist, image_angle);
    var _cy = y + lengthdir_y(_offset_dist, image_angle);

    draw_set_color(c_white);
    draw_set_alpha(0.2);
    draw_circle(_cx, _cy, 25, false); 
    draw_set_alpha(1);

    draw_set_color(c_yellow);
    
    draw_triangle(
        _cx - 8, _cy - 35,  // Punta Sup. Izq.
        _cx + 8, _cy - 35,  // Punta Sup. Der.
        _cx,     _cy - 20,  // Punta Inferior
        false
    );
}

if (global.show_debug_rays && log_stats) {
    
    // Configuración visual
    var _sensor_range = global.nn_config.sensor_range;
    
    var _colors = [
        c_red, c_red, c_red,           // 1-3
        c_purple,                      // 4
        c_lime, c_lime, c_lime,        // 5-7
        c_yellow, c_yellow, c_yellow   // 8-10
    ];
    
    var _angles = [ 0, 45, -45, 0, 0, 30, -30, 0, 90, -90 ];

    draw_set_alpha(0.6); 
    
    for (var i = 0; i < 10; i++) {
        var _key = "x" + string(i + 1);
        var _is_active = true;
        if (variable_struct_exists(global.nn_config, _key)) {
            _is_active = global.nn_config[$ _key];
        }

        if (!_is_active) continue;
        
        var _final_angle = image_angle + _angles[i];
        var _end_x = x + lengthdir_x(_sensor_range, _final_angle);
        var _end_y = y + lengthdir_y(_sensor_range, _final_angle);
        
        draw_line_width_color(x, y, _end_x, _end_y, 2, _colors[i], _colors[i]);
        draw_circle_color(_end_x, _end_y, 3, _colors[i], _colors[i], false);
    }
    
    draw_set_alpha(1); 
}