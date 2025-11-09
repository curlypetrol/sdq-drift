// Meta: Para pasar de nivek
switch (room) {
    case rm_Level1: room_goto(rm_Level2); break;
    case rm_Level2: room_goto(rm_Level3); break;
    default: room_restart(); break;
}
