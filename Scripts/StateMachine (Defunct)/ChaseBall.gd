'''
extends State
class_name ChaseBall


@onready var opposing_team: CharacterBody3D = get_parent().get_parent()
var ball : RigidBody3D = null

func _ready() -> void:
	ball = get_tree().get_first_node_in_group("Ball")
	
func _process(delta: float) -> void:
	opposing_team.navigation_agent_3d.set_target_position(ball.global_position)

	if opposing_team.global_position.distance_to(ball.global_position) > opposing_team.chase_distance:
		emit_signal("Transitioned", self, "Wander")
	
func _physics_process(delta: float) -> void:
	if opposing_team.navigation_agent_3d.is_navigation_finished():
		return
		
	var next_path_location = opposing_team.navigation_agent_3d.get_next_path_position()
	#var new_velocity = opposing_team.global_position.direction_to(next_path_location) * opposing_team.SPEED
			
	opposing_team.velocity = opposing_team.global_position.direction_to(next_path_location) * opposing_team.SPEED
	#opposing_team.velocity.move_toward(new_velocity, 0.25)

	
'''
