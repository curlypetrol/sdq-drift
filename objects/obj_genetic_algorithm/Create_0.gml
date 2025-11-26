n_bots = global.ga_config[$ "n"];
select_pct = global.ga_config[$ "select"];
mutation_prob = global.ga_config[$ "mut"];

n_generations = 0;
custom_gene = global.custom_gene;

best_gene = noone;
best_reward = 0;

bots = ds_list_create();
genes = ds_list_create();

// --- BENCHMARK FEATURE: INICIO ---
// Esto abrirá una ventana para que ELIJAS dónde guardar el archivo
var _path = get_save_filename("Text file|*.txt", "ga_benchmark_output.txt");

if (_path != "") {
    benchmark_filename = _path; // Usamos la ruta que tú elijas (elijan la carpeta z.outputs porfa)
    
    // Escribimos cabeceras solo si el archivo está vacío o lo queremos sobrescribir
    var _f = file_text_open_write(benchmark_filename);
    file_text_write_string(_f, "Generation;Fitness;Hue;Weights_JSON");
    file_text_writeln(_f);
    file_text_close(_f);
} else {
    // Si cancelas la ventana, usamos un nombre por defecto (se guardará en el Sandbox oculto)
    benchmark_filename = "ga_benchmark_output.txt";
}
// ---------------------------------

#region Genetic Algorithm

// Crea bot
function create_bot(_hue = noone, normal = undefined) {
    
    var _bot = instance_create_layer(x, y, "Instances", obj_bot);
    
    _hue = (_hue == noone) ? random_range(0, 360) : _hue;
    _bot.change_hue_shift(_hue);
    _bot.log_stats = false;
    

    var _bot_weights = undefined;
    var _bot_biases = undefined;
    
    if (normal == true and custom_gene != undefined) {
		_bot_weights = matrix_copy(custom_gene.weights);
		_bot_biases = matrix_copy(custom_gene.biases);
		_bot.change_hue_shift(custom_gene.hue)
		new_gens = {weights: _bot_weights, biases: _bot_biases};
		_bot.neural_network.set_genes(new_gens)
		_bot.fitness = 100;
		
    }
    else if (custom_gene != undefined) {
		_bot_weights = matrix_copy(custom_gene.weights);
		_bot_biases = matrix_copy(custom_gene.biases);
        _layers_count = array_length(_bot_weights);
        for(var lay = 0; lay < _layers_count; lay++) {
             _bot_weights[lay] = random_bias_mutate(_bot_weights[lay], 50, -0.75, 0.75, -1, 1);
             _bot_biases[lay] = random_bias_mutate(_bot_biases[lay], 50, -0.75, 0.75, -1, 1);
        }

        new_gens = {weights: _bot_weights, biases: _bot_biases};
		_bot.neural_network.set_genes(new_gens)
    }
	show_debug_message(string(_bot.neural_network.net.weights))
    return _bot;
    
}

// Inicializa población
function init_gen(_n) {
    bots_alive = _n;
    for (var i = 0; i < _n; i++) {
        var _bot = undefined
        if (i == 0) {
            _bot = create_bot(noone, true);
        } else {
			_bot = create_bot();
		}
        ds_list_add(bots, _bot);
    }

}

// Fitness function
function calculate_fitness(_gene) {
    return _gene.fitness; 
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

    
    for (var i = 0; i < _size; i++) {
        ds_list_add(_ordered, _genes[| i]);
    }
    
    for (var i = 0; i < ds_list_size(_ordered); i++) {
        for (var j = i+1; j < ds_list_size(_ordered); j++) {

            if (_ordered[| j].fitness > _ordered[| i].fitness) {
                var temp = _ordered[| i];
                _ordered[| i] = _ordered[| j];
                _ordered[| j] = temp;
            }

        }
    }

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
        var _r = max(0.0001, _g.fitness); 
        _total += _r;
    }

    repeat(_count)
    {
        var _pick = random_range(0, _total);
        var _accum = 0;

        for (var i = 0; i < _size; i++) {
            var _g = _genes[| i];
            var _r = max(0.0001, _g.fitness); 
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

function round2(v) {
    return round(v * 100) / 100;
}

function round_matrix2(mat) {
    var out = [];

    var rows = array_length(mat);
    for (var r = 0; r < rows; r++) {
        var row = mat[r];
        var cols = array_length(row);

        var new_row = [];
        for (var c = 0; c < cols; c++) {
            array_push(new_row, round2(row[c]));
        }

        array_push(out, new_row);
    }

    return out;
}
function round_gene_weights_biases(gene) {
    var new_w = [];
    var new_b = [];

    var layers = array_length(gene.weights);

    for (var i = 0; i < layers; i++) {
        array_push(new_w, round_matrix2(gene.weights[i]));
        array_push(new_b, round_matrix2(gene.biases[i]));
    }

    return {
        weights: new_w,
        biases: new_b
    };
}


// Nueva generación
function next_gen() {

    update_best_gene();
    
    // --- BENCHMARK FEATURE: CAPTURA DE DATOS ---
    // Guardamos los datos justo después de actualizar quién fue el mejor de esta generación
    if (best_gene != noone) {
        var _file = file_text_open_append(benchmark_filename); // Abrir en modo append (agregar al final)
        var rounded_struct = round_gene_weights_biases(best_gene);
		var _weights_json  = json_stringify(rounded_struct);

        
	    var _gen      = n_generations;
	    var _fit      = round2(best_reward);
	    var _hue      = round2(best_gene.hue);
	    var _json     = _weights_json;
	
        // Creamos la línea CSV: Generación, Fitness, Hue, JSON
        var _line = string(n_generations) + ";" + string(best_reward) + ";" + string(best_gene.hue) + ";" + _weights_json;
        
        file_text_write_string(_file, _line);
        file_text_writeln(_file);
        file_text_close(_file);
        
        show_debug_message("Benchmark guardado para Gen: " + string(n_generations));
    }
    // -------------------------------------------
    
    var _top_array = select_top(genes, select_pct);
    
    parents = ds_list_create();
    for (var k = 0; k < array_length(_top_array); k++) {
        ds_list_add(parents, _top_array[k]);
    }
    
    var _size_parents = ds_list_size(parents);
    
    ds_list_clear(bots);

 
    var elite_index = 0;
    show_debug_message("Mejor gen: " + string(best_gene));
    
    // --- BUCLE DE CREACIÓN DE NUEVA POBLACIÓN ---
    for (var i = 0; i < n_bots; i++) {
        
        // A) ELITISMO:
        if (i < _size_parents) {
            var _parent_data = parents[| i];
            
            var new_parent = create_bot(_parent_data.hue);

            new_parent.neural_network.net.weights = _parent_data.weights;
            new_parent.neural_network.net.biases = _parent_data.biases;
            
            // Si es el mejor absoluto, le ponemos la corona y activamos debug
            if (i == elite_index){
                new_parent.best_gene = true;
                new_parent.log_stats = true;

            } else {
                new_parent.best_gene = false;
                new_parent.log_stats = false;
            }
            
            ds_list_add(bots, new_parent);
            continue;
        }
        
        // B) REPRODUCCIÓN:
        
        // Selccion de padres
        var parents_crossing = select_parents(parents);
        var p1 = parents_crossing[0];
        var p2 = parents_crossing[1];
        
        // 3. Cruce

        var child_struct = crossover_gene(p1, p2); 
        var child_weights = child_struct.weights;
        var child_biases = child_struct.biases;
        
        // 4. Mutación
        var _layers_count = array_length(child_weights);
        for(var lay = 0; lay < _layers_count; lay++) {

			if(random(100) < 50){
	            child_weights[lay] = random_bias_mutate(child_weights[lay], mutation_prob, -0.75, 0.75, -1, 1);
	            child_biases[lay] = random_bias_mutate(child_biases[lay], mutation_prob, -0.75, 0.75, -1, 1);
			} else {
				child_weights[lay] = escalation_mutation(child_weights[lay], -1, 1, mutation_prob, 0.75);
				child_biases[lay] =  escalation_mutation(child_biases[lay], -1, 1, mutation_prob, 0.75);
			}
        }

        var bot = create_bot();
        bot.neural_network.net.weights = child_weights;
        bot.neural_network.net.biases = child_biases;
        
        // bot.image_blend = merge_color(p1.hue, p2.hue, 0.5);

        ds_list_add(bots, bot);
    }

    // Limpieza de memoria
    ds_list_destroy(parents);
    ds_list_clear(genes);   

    n_generations += 1;
    // show_debug_message("Best W of Gen:" + string(best_gene.weights))
    // show_debug_message("Best B of Gen:" + string(best_gene.biases))
    // show_debug_message("Best Reward:" + string(best_reward))
    // show_debug_message("Bots size: " + string(ds_list_size(bots)));

    
    // room_restart();
    bots_alive = n_bots;
}

// Inicializar primera generación
init_gen(n_bots);
custom_gene = undefined
bots[| n_bots - 1].log_stats = true;
randomize();
var s = random_get_seed();
show_debug_message("Seed: " + string(s))
#endregion