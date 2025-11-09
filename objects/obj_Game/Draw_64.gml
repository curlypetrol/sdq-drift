var txt = time_format_ms(race_elapsed_ms);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(16, 76, "TIME  " + txt);

if (race_best_ms >= 0) {
    draw_text(16, 96, "BEST  " + time_format_ms(race_best_ms));
}