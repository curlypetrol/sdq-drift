#region fitness
if (level_completed) {
	new_fitness = 5000 + (checkpoints_passed * 10) - (time_alive * 0.01);
}
else {
	new_fitness = (checkpoints_passed * 10) + (time_alive * 0.05);
}

if new_fitness > fitness {
	
	fitness = new_fitness	
}

#endregion
// Exportar genes
if (instance_exists(neural_network) && instance_exists(obj_genetic_algorithm)) {
    
    var _genes_struct = neural_network.get_genes();
    
    // Empaquetar ADN
    var _dna = {
        "weights": _genes_struct.weights,
        "biases": _genes_struct.biases,
        "fitness": fitness, 
        "hue": hue_shift,   
        "best_dist": distance_traveled 
    };
    
    // Guardar en manager
    ds_list_add(obj_genetic_algorithm.genes, _dna);
    
    // Limpieza red
    instance_destroy(neural_network);
}

obj_genetic_algorithm.bots_alive--

if(instance_number(obj_bot) == 1){
	obj_genetic_algorithm.next_gen()
}