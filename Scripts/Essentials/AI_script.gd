extends CharacterBody3D

@onready var enemy_shape_cast: ShapeCast3D = $Feet/EnemyShapeCast
@onready var navigation_agent_3d: NavigationAgent3D = $Feet/NavigationAgent3D

@export var ball_path : NodePath
@export var player_path : NodePath
@export var goal_path : NodePath
@export var home : bool

var teammates = []

'This is used mostly for the defenders and midfielders'
enum STATE {Idle, Wait, Wander, Attack, Pass, Push, Fall}
var state : STATE = STATE.Idle

var chase_distance = 15

var wander_timer : float = 0.2
var wander_timer_count : float = 0.0

'this determines if the AI is more likely to attack, pass, or defend'
'0 is attack, 1 is pass/playmaking, 2 is defend, 3 is goalie'
## 0 is attack, 1 is pass/ playmaker (defunct), 2 is defender, 3 is goalie
@export var play_type : int

'Set these values when deciding if enemy AI will chase player or the ball'
var ball = null
var player = null
var goal = null

var in_range = false
var target_reached
var SPEED = 5
var RUNSPEED = 6
var randomizer_number
var ball_close = false
var start_pos


func _ready():
	ball = get_node(ball_path)
	target_reached = false
	start_pos = global_position
	if home == true:
		set_collision_layer_value(6 , false)

	if is_in_group("PlayerTeam"):
		teammates = get_tree().get_nodes_in_group("PlayerTeam")
		teammates.append(get_tree().get_nodes_in_group("player"))
		print(teammates.find(get_tree().get_nodes_in_group("player")))
	if is_in_group("OpposingTeam"):
		teammates = get_tree().get_nodes_in_group("OpposingTeam")
		print(teammates)
	#assert(self in teammates)
	teammates.erase(self)
	#assert(not self in teammates)
	$Feet/EnemyShapeCast.teammates = teammates
	

func _physics_process(delta: float) -> void:
	if play_type == 0:
		if Global.scored == false:
			velocity += get_gravity() * delta
			move_AI(ball)
			move_and_slide()
	elif play_type == 1:
		pass
	elif play_type == 2:
		if Global.scored == false:
			velocity += get_gravity() * delta
			
			match state:
				STATE.Idle:
					_idle()
				STATE.Wait:
					_wait(delta)
				STATE.Wander:
					_wander()
				STATE.Attack:
					_attack(ball)
				STATE.Pass:
					_pass(ball)
				STATE.Push:
					pass
				STATE.Fall:
					pass
					
			move_and_slide()

func get_random_num():
	randomizer_number = randi_range(0, 100)
	return randomizer_number


func _on_navigation_agent_3d_target_reached() -> void:
	if Global.scored == true:
		pass
	target_reached = true
	if target_reached:
		if play_type == 2:
			if global_position.distance_to(ball.global_position) <= chase_distance:
				state = STATE.Attack
			else:
				state = STATE.Idle

func _on_enemy_shooting_area_body_entered(_body: Node3D) -> void:
	print("here")
	in_range = true


func _on_enemy_shooting_area_body_exited(_body: Node3D) -> void:
	print("gone")
	in_range = false


func move_AI(path):
	navigation_agent_3d.set_target_position(path.global_position)
	var next_path_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_path_location - global_position).normalized() * SPEED
			
	velocity = velocity.move_toward(new_velocity, 0.1)


##################################################################################3
'state machine functions'

func _idle():
	velocity = Vector3.ZERO
	wander_timer_count = wander_timer
	state = STATE.Wait
	
func _wait(delta):
	wander_timer_count -= delta
	
	if wander_timer_count <= 0.0:
		var target = get_random_location()
		navigation_agent_3d.target_position = target
		state = STATE.Wander
		
func _wander():
	var current_position = global_position
	var next_pos = navigation_agent_3d.get_next_path_position()
	var direction = (next_pos - current_position).normalized()
	velocity = direction * SPEED
	if global_position.distance_to(ball.global_position) <= chase_distance:
		state = STATE.Attack
	
func _attack(path):
	var current_position = global_position
	navigation_agent_3d.target_position = path.global_position
	var next_pos = navigation_agent_3d.get_next_path_position()
	var direction = (next_pos - current_position).normalized()
	velocity = direction * RUNSPEED
	if global_position.distance_to(ball.global_position) > chase_distance:
		state = STATE.Idle
	'''
	if Global.in_possession_away and self.is_in_group("OpposingTeam"):
		state = STATE.Push
	if Global.in_possession_home and self.is_in_group("PlayerTeam"):
		state = STATE.Push
	'''
	
func _fall():
	pass

func _push():
	if Global.in_possession_away == false and self.is_in_group("OpposingTeam"):
		state = STATE.Idle
	if Global.in_possession_home == false and self.is_in_group("PlayerTeam"):
		state = STATE.Idle


func _pass(path):
	pass

func get_random_location() -> Vector3:
	var random_X = randi_range(-15, 15)
	var random_Z = randi_range(-10, 10)
	var random_loc = Vector3(start_pos.x + (random_X), 0, start_pos.z + (random_Z))
	return random_loc

#################################################################################################
'Area Functions for the ball detection and state changes'
func _on_enemy_players_body_entered(body: Node3D) -> void:
	if body == get_tree().get_first_node_in_group("Ball") and self.is_in_group("OpposingTeam"):
		print("I got it")
		Global.in_possession_away = true
	if body == get_tree().get_first_node_in_group("Ball") and self.is_in_group("PlayerTeam"):
		print("I got it")
		Global.in_possession_home = true


func _on_enemy_players_body_exited(body: Node3D) -> void:
	if body == get_tree().get_first_node_in_group("Ball") and self.is_in_group("OpposingTeam"):
		print("I lost it")
		Global.in_possession_away = false
	if body == get_tree().get_first_node_in_group("Ball") and self.is_in_group("PlayerTeam"):
		print("I lost it")
		Global.in_possession_home = false
