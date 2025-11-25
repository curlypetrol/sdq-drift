n_bots = global.ga_config[$ "n"];
select_pct = global.ga_config[$ "select"];
mutation_prob = global.ga_config[$ "mut"];

n_generations = 0;


best_gene = noone;
best_reward = 0;

bots = ds_list_create();
genes = ds_list_create();

#region Genetic Algorithm

// Crea bot
function create_bot(_hue = noone) {
	
    var _bot = instance_create_layer(x, y, "Instances", obj_bot);
    _hue = (_hue == noone) ? random_range(0, 360) : _hue;
	_bot.change_hue_shift(_hue);
    _bot.log_stats = false;
	// show_debug_message("Creating Bot | Hue:" + string(_bot.hue_shift))
    return _bot;
	
}

// Inicializa población
function init_gen(_n) {
	bots_alive = _n;
    repeat(_n) {
        var _bot = create_bot();
        ds_list_add(bots, _bot);
    }
}

// Fitness function
function calculate_fitness(_gene) {
    return _gene.best_dist; 
}

// Cruuce
function crossover_gene(p1, p2){
    var new_w = [];
    var new_b = [];

    var layers = array_length(p1.weights);

    for (var i = 0; i < layers; i++){
        var w1 = p1.weights[i];
        var w2 = p2.weights[i];

        var b1 = p1.biases[i];
        var b2 = p2.biases[i];

        // Tu cruce de un punto
        var cw = crossover_matrix_one_point(w1, w2);
        var cb = crossover_matrix_one_point(b1, b2);

        array_push(new_w, cw);
        array_push(new_b, cb);
    }

    return { weights: new_w, biases: new_b };
}


// Guarda mejor
function update_best_gene() {
    for (var i = 0; i < ds_list_size(genes); i++) {
        var g = genes[| i];
        var f = calculate_fitness(g);

        if (f > best_reward) {
            best_reward = f;
            best_gene = g;
        }
    }
}

// Seleccion por estilismo
function select_top(_genes, _percent)
{
    var _size = ds_list_size(_genes);
    if (_size == 0) return [];

    var _selected = [];
    var _ordered = ds_list_create();

    // Copiar para no dañar la original
    for (var i = 0; i < _size; i++) {
        ds_list_add(_ordered, _genes[| i]);
    }

    // Ordenar por reward descendente
    ds_list_sort(_ordered, true);

    // Cantidad a seleccionar
    var _count = max(1, ceil(_size * (_percent/100)));

    for (var i = 0; i < _count; i++) {
        array_push(_selected, _ordered[| i]);
    }

    ds_list_destroy(_ordered);

    return _selected;
}

// Selección por probabilidad
function select_weighted(_genes, _percent)
{
    var _size = ds_list_size(_genes);
    if (_size == 0) return [];

    var _selected = [];
	    // Cantidad a seleccionar
    var _count = max(1, ceil(_size * (_percent/100)));
	
    // Calcular suma total de rewards
    var _total = 0;
    for (var i = 0; i < _size; i++) {
        var _g = _genes[| i];
        var _r = max(0.0001, _g.best_dist); 
        _total += _r;
    }

    repeat(_count)
    {
        var _pick = random_range(0, _total);
        var _accum = 0;

        for (var i = 0; i < _size; i++) {
            var _g = _genes[| i];
            var _r = max(0.0001, _g.best_dist);
            _accum += _r;

            if (_accum >= _pick) {
                array_push(_selected, _g);
                break;
            }
        }
    }

    return _selected;
}

function select_parents(_genes) {
    var _size = ds_list_size(_genes);

    var p1 = irandom(_size - 1);
    var p2 = irandom(_size - 1);

    while (p2 == p1) {
        p2 = irandom(_size - 1);
    }

    // Crear un array con los dos padres
    return [_genes[| p1], _genes[| p2]];
}


// Nueva generación
// Nueva generación
function next_gen() {

    update_best_gene();
    
    // 1. CORRECCIÓN: Usar 'genes' en lugar de 'bots'
    // 'genes' tiene la info guardada al morir. 'bots' son instancias activas (que ya no sirven aquí).
    // select_top devuelve un ARRAY.
    var _top_array = select_top(genes, select_pct);
    
    // 2. CORRECCIÓN: Convertir Array a DS List
    // Para que las funciones select_parents y ds_list_size funcionen, necesitamos una lista.
    parents = ds_list_create();
    for (var k = 0; k < array_length(_top_array); k++) {
        ds_list_add(parents, _top_array[k]);
    }
    
    var _size_parents = ds_list_size(parents); // Ahora sí funciona porque es una lista
    
    // Limpiar bots anteriores
    ds_list_clear(bots);
    
    // Buscar al mejor (Elite)
    var elite_index = ds_list_find_index(parents, best_gene);
    
    // --- BUCLE DE CREACIÓN DE NUEVA POBLACIÓN ---
    for (var i = 0; i < n_bots; i++) {
        
        // A) ELITISMO: Los mejores pasan directo sin cambios
        if (i < _size_parents) {
            var _parent_data = parents[| i]; // Accedemos a la lista con accesores
            
            var new_parent = create_bot(_parent_data.hue);
            // Copiamos los pesos directamente
            new_parent.neural_network.net.weights = _parent_data.weights;
            new_parent.neural_network.net.biases = _parent_data.biases;
            
            // Si es el mejor absoluto, le ponemos la corona y activamos debug
            if (i == elite_index){
                // new_parent.crown.visible = true;
                new_parent.log_stats = true;    
            }
            ds_list_add(bots, new_parent);
            continue;
        }
        
        // B) REPRODUCCIÓN: Cruce y Mutación para el resto
        
        // Seleccionamos 2 padres aleatorios de la lista de 'parents'
        var parents_crossing = select_parents(parents);
        var p1 = parents_crossing[0];
        var p2 = parents_crossing[1];
        
        // 3. CORRECCIÓN: Usar la función helper 'crossover_gene'
        // Antes estabas llamando a crossover_matrix... directamente sobre el array de pesos,
        // lo cual daría error. crossover_gene maneja el bucle por capas.
        var child_struct = crossover_gene(p1, p2); 
        var child_weights = child_struct.weights;
        var child_biases = child_struct.biases;
        
        // 4. CORRECCIÓN: Mutación por capas
        // child_weights es un array de matrices. Debemos mutar capa por capa.
        var _layers_count = array_length(child_weights);
        for(var lay = 0; lay < _layers_count; lay++) {
             // Asumiendo que ya creaste el script random_bias_mutate que te pasé antes
             child_weights[lay] = random_bias_mutate(child_weights[lay], mutation_prob, -0.75, 0.75, -1, 1);
             child_biases[lay] = random_bias_mutate(child_biases[lay], mutation_prob, -0.75, 0.75, -1, 1);
        }

        var bot = create_bot();
        bot.neural_network.net.weights = child_weights;
        bot.neural_network.net.biases = child_biases;
        
        // Opcional: Mezclar color
        // bot.image_blend = merge_color(p1.hue, p2.hue, 0.5);

        ds_list_add(bots, bot);
    }

    // Limpieza de memoria
    ds_list_destroy(parents); // Ya usamos la lista, la borramos
    ds_list_clear(genes);     // Limpiamos los genes viejos para la nueva ronda

    n_generations += 1;
	// show_debug_message("Best W of Gen:" + string(best_gene.weights))
	// show_debug_message("Best B of Gen:" + string(best_gene.biases))
	// show_debug_message("Best Reward:" + string(best_reward))
	// show_debug_message("Bots size: " + string(ds_list_size(bots)));

	
    // Si tu juego necesita reiniciar obstáculos:
    // room_restart();
	bots_alive = n_bots;
}

// Inicializar primera generación
init_gen(n_bots);
bots[| n_bots - 1].log_stats = true;

#endregion