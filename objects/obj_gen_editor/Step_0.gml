if (keyboard_check_pressed(vk_control) && keyboard_check_pressed(ord("V"))) {
    user_input = clipboard_get_text();
}
