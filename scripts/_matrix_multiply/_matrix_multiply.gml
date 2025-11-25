function _matrix_multiply(a, b){
	
	// Obtener dimensiones de los arrays
	var am = array_length(a);
	var an = array_length(a[0]);
	var bm = array_length(b);
	var bn = array_length(b[0]);
	
	if (an != bm) {
		return undefined;
	}
	
	// La matriz resultante tendrá dimensiones: filas de A x columnas de B
	var _matrix = array_create(am);
	
	for(var _i = 0; _i < am; _i++){
		// Inicializamos la fila con 0s para poder sumar acumulativamente
		var _row = array_create(bn, 0); 
		
		for(var _j = 0; _j < bn; _j++){
			// Producto punto: suma de A[_i][_k] * B[_k][_j]
			var _sum = 0;
			for(var _k = 0; _k < an; _k++){
				_sum += a[_i][_k] * b[_k][_j];
			}
			_row[_j] = _sum;
		}
		_matrix[_i] = _row;
	}
	
	return _matrix;
}