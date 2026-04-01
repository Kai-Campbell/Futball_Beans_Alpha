extends Area3D

@export var home = false
var scored = false

func _on_body_entered(body: Node3D) -> void:
	if scored:
		return
	if body.is_in_group("Ball"):
		Global.score.emit()
		print("GOAL!!!!!!")
		#Below adds a delay and sends the ball back to the middle upon a goal
		scored = true
		Global.scored = true
		await get_tree().create_timer(1).timeout
		if home == false:
			Global.homeScore += 1
		else:
			Global.awayScore += 1
		await get_tree().create_timer(3).timeout
		body.reset()
		scored = false
		Global.scored = false
