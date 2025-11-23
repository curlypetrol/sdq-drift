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

// Limpieza visualizador
if (instance_exists(nn_viewer)) {
    instance_destroy(nn_viewer);
}

// Fin de ronda
if (instance_number(obj_bot) <= 1) { 
    if (instance_exists(obj_genetic_algorithm)) {
        with(obj_genetic_algorithm) {
            next_gen(); // Siguiente gen
        }
    }
}
