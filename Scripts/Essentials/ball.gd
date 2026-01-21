extends RigidBody3D

'player variables'
var shootingstrength = 25
#var dribblestrength = 1.0 #Not in use
var kickstrength = 5.0
var arcHeight = 12

var start # reset spot for death barrier


func _ready() -> void:
	start = global_position
	
'player functions'

func _kickball(player):
	apply_impulse(player.get_direction() * kickstrength)

# no longer in use method
#func _stop_ball(player):
	#apply_impulse(-(player.get_direction()) * kickstrength)

#makes the shot go in the air
func _arcShotball(player):
	apply_impulse(player.basis.y * arcHeight)
	apply_impulse(-player.basis.z * shootingstrength)
	

func _shootball(player):
	apply_impulse(-player.basis.z * kickstrength * 6)

func reset():
	global_position = start
	

func _pass_to_enemy(enemy : Vector3):
	pass
	
