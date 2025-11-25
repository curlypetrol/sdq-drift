function crossover_matrix_one_point(parent1, parent2){
    
    var rows = array_length(parent1);
    var cols = array_length(parent1[0]);
    
    // Copias para no dañar los originales
    var child = matrix_copy(parent1);

    // Punto de corte (se elige por índice lineal)
    var total_genes = rows * cols;
    var cut_point = irandom_range(0, total_genes - 1);

    // Pasamos el índice lineal a coordenadas
    var count = 0;

    for (var i = 0; i < rows; i++){
        for (var j = 0; j < cols; j++){
            if (count > cut_point){
                child[i][j] = parent2[i][j];
            }
            count++;
        }
    }
    return child;
}

