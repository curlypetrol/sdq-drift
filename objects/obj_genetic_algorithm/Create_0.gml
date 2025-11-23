n_bots = global.nn_config[$ "n"];
select_pct = global.nn_config[$ "select"];
mutation_prob = global.nn_config[$ "mut"];

n_generations = 0;

best_gene = noone;
best_reward = 0;

bots = ds_list_create();
genes = ds_list_create();

#region Genetic Algorithm

// Crea bot
function create_bot(_hue = noone) {
    var _bot = instance_create_layer(x, y, "Instances", obj_Player);
    _bot.hue_shift = (_hue == noone) ? random_range(0, 360) : _hue;
    _bot.log_stats = false;
    return _bot;
}

// Inicializa población
function init_gen(_n) {
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
    var _count = max(1, floor(_size * _percent));

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
    var _count = max(1, floor(_size * _percent));
	
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
function next_gen() {

    update_best_gene();
	
	parents = ds_list_create();
	parents = select_top(bots, select_pct);
	
	var _size_parents = ds_list_size(parents);
	ds_list_clear(bots);
	var elite_index = ds_list_find_index(parents, best_gene);
	
    // Crear hijos mediante selección, crossover y mutación
    for (var i = 0; i < n_bots - 1; i++) {
		if (i < _size_parents){
			
			var new_parent = create_bot(parents[i].hue);
			new_parent.neural_network.net.weights = parents[i].weights;
			new_parent.neural_network.net.biases = parents[i].biases
			
			// Si el padre que tenemos es el mejor, le agregamos la coronita
			if (i == elite_index){
				new_parent.crown.visible = true;
				new_parent.log_stats = true;	
			}
			ds_list_add(bots, new_parent);
			continue
		}
		
        var parents_crossing = select_parents(parents);
		var p1 = parents[0]
		var p2 = parents[1]
		
		// Cruce
        var child_weights = crossover_matrix_one_point(p1.weights, p2.weights);
		var child_biases = crossover_matrix_one_point(p1.biases, p2.biases);
        
		// Mutacion
		child_weights = random_bias_mutate(child_weights, mutation_prob, -0.75, 0.75, -1, 1);
		child_biases = random_bias_mutate(child_biases, mutation_prob, -0.75, 0.75, -1, 1);

        var bot = create_bot();
        bot.neural_network.net.weights = child_weights;
        bot.neural_network.net.biases = child_biases;

        ds_list_add(bots, bot);
    }

    // Limpiar genes para la próxima gen
    ds_list_clear(genes);

    n_generations += 1;
}

// Inicializar primera generación
init_gen(n_bots);
bots[| n_bots - 1].log_stats = true;

#endregion
