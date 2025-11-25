audio_play_sound(snd_booster, 10, false);

state = PlayerState.BOOST;
boost_timer = 120;

instance_destroy(other);