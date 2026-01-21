extends Node3D

@onready var timer: Label3D = $Timer
@onready var countdown_timer: Timer = $"Countdown Timer"

func start_countdown():
	countdown_timer.start()
	
func time_left_in_match():
	var time_left = countdown_timer.time_left
	var minute = floor(time_left / 60)
	var seconds = int(time_left) % 60
	return [minute, seconds]
	
func _process(delta: float) -> void:
	timer.text = "%02d:%02d" % time_left_in_match()
