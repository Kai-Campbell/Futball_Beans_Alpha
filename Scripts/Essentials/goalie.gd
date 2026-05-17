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
@onready var hands: Node3D = $Hands

@export var ball_path : NodePath
@export var player_path : NodePath
@export var pass_speed : int = 20
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

var shooting_high : bool = false
var target_pos = null

enum state {MOVE, JUMP}
var State = state.MOVE



func _ready():
	ball = get_node(ball_path)
	target_reached = false
	Global.kick_target.connect(jump)
	if home == true:
		Global.in_possession_home = false
	else:
		Global.in_possession_away = false
	
func _physics_process(delta: float) -> void:
	var ball_pos
	ball_pos = Vector3(ball.global_position.x, ball.global_position.y, global_position.z)
	if Global.scored == false:
		velocity += get_gravity() * delta
		match State:
			state.MOVE:
				_move(ball_pos)
			state.JUMP:
				_jump(ball_pos)
		
		move_and_slide()
		


func _move(path):
	navigation_agent_3d.set_target_position(path)
	var next_path_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_path_location - global_position).normalized() * SPEED
	
	velocity = new_velocity

func _jump(path):
	pass


func _on_navigation_agent_3d_target_reached() -> void:
	if home == true:
		Global.in_possession_home = true
	else:
		Global.in_possession_away = true

func jump(where):
	shooting_high = true
	target_pos = where


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Ball"):
		$Area3D.monitoring = false
		body.freeze = true
		body.global_position = hands.global_position
		$"Hold Timer".start()
		await $"Hold Timer".timeout
		body.freeze = false
		if home:   #this should be changed to passing to teammates but works now very good
			body.apply_central_impulse((Global.away_goal_pos - global_position).normalized() * pass_speed)
		else:
			body.apply_central_impulse((Global.home_goal_pos - global_position).normalized() * pass_speed)
		$Area3D.monitoring = true
