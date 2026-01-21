extends CharacterBody3D

'''This a more simplified version of the enemy AI but it is not used because it wasnt

   very scalable. Also the use of secondary function was very outdated.

# this part goes into the physics process
	var current_location = global_transform.origin
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	
	move_and_slide()

func set_target_location(target):
	navigation_agent_3d.set_target_position(target)
	
# place this in the maps script
func _physics_process(delta: float) -> void:
	get_tree().call_group("OpposingTeam", "set_target_location", ball.global_transform.origin)

'''

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

@export var ball_path : NodePath
@export var player_path : NodePath

@export var home = false

'this determines if the AI is more likely to attack, pass, or defend'
'0 is attack, 1 is pass/playmaking, and 2 is defend, 3 is goalie'
@export var play_type : int

'Set these values when deciding if enemy AI will chase player or the ball'
var ball = null
var player = null
var goal = null

var ball_in_range = false
var target_reached
var SPEED = 15
var gravity = 20


func _ready():
	ball = get_node(ball_path)
	target_reached = false
	if home == true:
		Global.in_possession_home = false
	else:
		Global.in_possession_away = false
	
func _physics_process(delta: float) -> void:
	var ball_pos
	if Global.scored == false:
		#if global_position.distance_to(ball.global_position) <= 30:
		ball_pos = Vector3(ball.global_position.x, ball.global_position.y, global_position.z)
		#else:
			#ball_pos = Vector3(ball.global_position.x, ball.global_position.y, global_position.z)
		navigation_agent_3d.set_target_position(ball_pos)
		var next_path_location = navigation_agent_3d.get_next_path_position()
		var new_velocity = (next_path_location - global_position).normalized() * SPEED
		
		velocity = new_velocity
		velocity += get_gravity() * delta
		
		move_and_slide()
		#velocity.move_toward(new_velocity, 0.25)


func _on_navigation_agent_3d_target_reached() -> void:
	if home == true:
		Global.in_possession_home = true
	else:
		Global.in_possession_away = true
