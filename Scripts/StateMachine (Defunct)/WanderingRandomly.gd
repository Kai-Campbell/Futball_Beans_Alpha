'''
extends State
class_name Wander

@onready var opposing_team: CharacterBody3D = get_parent().get_parent()
var ball : RigidBody3D = null

var wander_dir : Vector3
var wander_time : float = 0.0

func _ready() -> void:
	ball = get_tree().get_first_node_in_group("Ball")

func randomize_vars():
	var random_X = randi_range(-15, 15)
	var random_Z = randi_range(-10, 10)
	#wander_dir = Vector3(opposing_team.global_position.x + (random_X), opposing_team.global_position.y, opposing_team.global_position.z + (random_Z))
	wander_time = randf_range(1.5, 5)
	wander_dir = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
	
func enter():
	randomize_vars()

func _process(delta: float) -> void:
	if wander_time < 0.1:
		randomize_vars()
	
	wander_time -= delta

	if opposing_team.global_position.distance_to(ball.global_position) < opposing_team.chase_distance:
		emit_signal("Transitioned", self, "ChaseBall")
		
func _physics_process(delta: float) -> void:
	opposing_team.velocity = wander_dir * opposing_team.SPEED
	
	if not opposing_team.is_on_floor():
		opposing_team.velocity += opposing_team.get_gravity()
'''
