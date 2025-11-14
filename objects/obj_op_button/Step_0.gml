// Tamaño de los botones
btn_width  = 200;
btn_height = 60;

// Espaciado y posiciones (centrados)
start_y = 300;      // posición Y de la fila principal
gap_y   = 150;      // separación hacia el botón de volver

// Fila: [Vueltas][ - ][ valor ][ + ]
label_w = 200;  label_h = 60;   // rectángulo "Vueltas"
sq_w    = 60;   sq_h    = 60;   // cuadrados +/- 
val_w   = 80;   val_h   = 60;   // recuadro del valor
gap_x   = 16;                 // espacio horizontal entre elementos

row_total_w = label_w + gap_x + sq_w + gap_x + val_w + gap_x + sq_w;
row_x = room_width/2 - row_total_w/2;

// Rectángulos (guardar en variables para usar en Draw y Left Pressed)
label_x = row_x;
label_y = start_y;

btn_minus_x = label_x + label_w + gap_x;
btn_minus_y = start_y;

val_x = btn_minus_x + sq_w + gap_x;
val_y = start_y;

btn_plus_x = val_x + val_w + gap_x;
btn_plus_y = start_y;

// Botón volver al menú principal (centrado)
btn_back_w = 200;
btn_back_h = 60;
btn_back_x = room_width/2 - btn_back_w/2;
btn_back_y = start_y + gap_y;
