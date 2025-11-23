no_input = true

// Revisamos los 10 sensores
for (var _j = 0; _j < 10; _j++)
{
    var _key = "x" + string(_j + 1);
    if (variable_struct_exists(global.nn_config, _key)) {
        no_input = (no_input and !global.nn_config[$ _key]);
    }
}