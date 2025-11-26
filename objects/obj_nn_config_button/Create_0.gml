// Configuración UI
padding_x = 50;
padding_y = 80; 
line_height = 40;

// 1. Sensores
sensors = [
    { label: "1. Mortal Frontal", key: "x1" },
    { label: "2. Aceite Frontal", key: "x2" },
    { label: "3. Boost Frontal",  key: "x3" },
    { label: "4. Boost Izq",      key: "x4" },
    { label: "5. Boost Der",      key: "x5" },
    { label: "6. Offroad Front",  key: "x6" },
    { label: "7. Offroad Izq",    key: "x7" },
    { label: "8. Offroad Der",    key: "x8" },
    { label: "9. Muro Seguro F",  key: "x9" },
    { label: "10. Muro Seguro L", key: "x10" },
    { label: "11. Muro Seguro R", key: "x11" }
];

// 2. Capas Neuronales
layers_conf = [
    { label: "Capa Oculta 1", key: "h1" },
    { label: "Capa Oculta 2", key: "h2" },
    { label: "Capa Oculta 3", key: "h3" },
    { label: "Capa Oculta 4", key: "h4" }
];

// 3. Algoritmo Genético
// Config: Label, key, min, max, step
ga_conf = [
    { label: "Poblacion",   key: "n",      min: 2,  max: 100, step: 2 },
    { label: "Seleccion %", key: "select", min: 5,  max: 90,  step: 5 },
    { label: "Mutacion %",  key: "mut",    min: 0,  max: 100, step: 5 } 
];

// Botón volver
btn_back_rect = [room_width - 250, room_height - 80, room_width - 50, room_height - 20];