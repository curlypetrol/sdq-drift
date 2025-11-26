var _str = obj_gen_editor.user_input;

try {
    var _parsed = json_parse(_str);
    
    if (is_struct(_parsed)) {
        global.custom_gene = _parsed;
        obj_gen_editor.status_msg = "Gen actualizado correctamente.";
    } else {
        obj_gen_editor.status_msg = "El texto no es una estructura válida.";
    }
} catch (e) {
    obj_gen_editor.status_msg = "Error al parsear JSON. Revisa comas, corchetes, \"\".";
}
