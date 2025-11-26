// Tamaño de los botones
btn_width  = 100;
btn_height = 60;

// Espaciado y posiciones (centrados)
start_y = 300;      // SUBIMOS un poco la fila inicial para hacer espacio
gap_y   = 150;      // Separación vertical entre filas

// --- Fila 1: [Vueltas][ - ][ valor ][ + ] ---
label_w = 150;  label_h = 60;
sq_w    = 60;   sq_h    = 60;
val_w   = 70;   val_h   = 60;
gap_x   = 20;

row_total_w = label_w + gap_x + sq_w + gap_x + val_w + gap_x + sq_w;
row_x = room_width/2 - row_total_w/2;

label_x = row_x;
label_y = start_y;

btn_minus_x = label_x + label_w + gap_x;
btn_minus_y = start_y;

val_x = btn_minus_x + sq_w + gap_x;
val_y = start_y;

btn_plus_x = val_x + val_w + gap_x;
btn_plus_y = start_y;

// --- Fila 2: Botón Configurar Red Neuronal ---
btn_nn_w = 200;
btn_nn_h = 70;
btn_nn_x = room_width/2 - btn_nn_w/2;
btn_nn_y = start_y + gap_y; // Debajo de las vueltas

// --- Fila 3: Botón Volver (Menu Principal) ---
btn_back_w = 180; // Lo hice un poco más ancho para que coincida
btn_back_h = 60;
btn_back_x = room_width/2 - btn_back_w/2;
btn_back_y = btn_nn_y + gap_y; // Debajo del botón de NN