// Tamaño de los botones
btn_width  = 200;
btn_height = 50;

// Espaciado y posiciones
start_y = 230;      // Altura inicial (ajustar si es necesario)
gap_y   = 100;       // Separación vertical entre filas
gap_x   = 120;       // Separación horizontal entre columnas

// Calculamos la X de la columna central para usarla de referencia
var center_x = room_width / 2 - btn_width / 2;

// --- COLUMNA 1 (IZQUIERDA) - FÁCILES ---
// Se resta el ancho del botón y el gap a la posición central
btn1_x = center_x - btn_width - gap_x;
btn1_y = start_y;          // Nivel 1

btn2_x = btn1_x;
btn2_y = start_y + gap_y;  // Nivel 2

// --- COLUMNA 2 (CENTRO) - INTERMEDIOS ---
// Está exactamente en el centro
btn3_x = center_x;
btn3_y = start_y;          // Nivel 3

btn4_x = center_x;
btn4_y = start_y + gap_y;  // Nivel 4

// --- COLUMNA 3 (DERECHA) - INTERMEDIO ALTO ---
// Se suma el ancho del botón y el gap a la posición central
btn5_x = center_x + btn_width + gap_x;
btn5_y = start_y;          // Nivel 5

btn6_x = btn5_x;
btn6_y = start_y + gap_y;  // Nivel 6

// --- BOTONES CENTRALES INFERIORES ---
// Se ubican debajo de las columnas (gap_y * 2 en adelante)

// Nivel 7 (Avanzado)
btn7_x = center_x;
btn7_y = start_y + gap_y * 2;

// Botón Volver
btn_back_x = center_x;
btn_back_y = start_y + gap_y * 3;

// Botón Salir
btn_exit_x = center_x;
btn_exit_y = start_y + gap_y * 4;