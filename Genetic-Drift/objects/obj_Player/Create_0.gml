// Dirección y velocidad
facing = 0;         
vx = 0; vy = 0;

// Para controlar la aceleración y derrape
base_accel   = 0.25;
turn_rate    = 3.0;   
friction     = 0.20  
drift_keep   = 1.0;  

// Velocidad dependiendo del terreno o si tiene nitro
max_asphalt  = 7.0;
max_offroad  = 4.8;
max_boost    = 11.0;

// Estados temporales
state = PlayerState.NORMAL;
oil_timer = 0;
boost_timer = 0;

// Para choque de frente
front_kill_cone = 60;    
min_kill_speed  = 3.0;   


sprite_looks_up = false;