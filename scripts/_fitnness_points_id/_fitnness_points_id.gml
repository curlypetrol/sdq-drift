function id_manager(_mode) {
    static counter = 0;

    if (_mode == "next") {
        counter++;
        return counter-1;
    }

    if (_mode == "total") {
        return counter;
    }

    if (_mode == "reset") {
        counter = 0;
    }
}
