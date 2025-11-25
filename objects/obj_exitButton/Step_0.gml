// Obtener la cámara actual
var cam = view_camera[0];

// Posición de la vista
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

// Ajustar posición del botón en relación a la cámara
x = cam_x + 470; // margen desde la izquierda
y = cam_y + 20; // margen desde arriba
