draw_set_font(-1);
draw_set_halign(fa_center);

draw_text(display_get_gui_width()/2, 20, "Generation " + string(n_generations));
draw_text(display_get_gui_width()/2, 50, "Best Fitness: " + string(best_reward));
draw_text(display_get_gui_width()/2, 80, "N: " + string(bots_alive));
