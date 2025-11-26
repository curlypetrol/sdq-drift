if (other.next_checkpoint == checkpoint_index) {
    other.checkpoints_passed++;
    other.next_checkpoint++;
    other.dont_avance_counter = 0
}