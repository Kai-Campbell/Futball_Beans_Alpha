extends AudioStreamPlayer

const menu_music = preload("res://Assets/Music/THISISFIRE.mp3")

func play_music(music: AudioStream):
	if stream == music:
		return
	
	stream = music
	play()

func play_menu_music():
	play_music(menu_music)

func stop_music():
	if stream == null:
		return
	
	stop()
