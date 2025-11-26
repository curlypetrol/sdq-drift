if (other.next_checkpoint == checkpoint_index) {
    other.checkpoints_passed++;
    other.next_checkpoint++;
	show_debug_message("Carro " + string(other.hue_shift) + " Paso indice: " + string(checkpoint_index))
    // if (other.next_checkpoint >= other.total_checkpoints) {
    //    other.next_checkpoint = 0;
    // }
}