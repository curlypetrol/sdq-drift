draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Time
var total_ms = race_elapsed_ms;
var total_sec = total_ms div 1000;
var mm = total_sec div 60;
var ss = total_sec mod 60;
var cc = (total_ms mod 1000) div 10;

var time_str = string_format(mm,2,0) + ":" + string_format(ss,2,0) + ":" + string_format(cc,2,0);
draw_text(16, 76, "TIME  " + time_str);

// Vueltas
draw_text(16, 96, "LAP   " + string(lap_current) + " / " + string(lap_need));
