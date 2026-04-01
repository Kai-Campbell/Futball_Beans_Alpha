extends ShapeCast3D

@onready var opposing_team_player: CharacterBody3D = $"../.."
var can_kick = true
@onready var kick_timer: Timer = $"../../KickTimer"
var kickCounter = 0 #how many kicks before a pass is done

var teammates = []
var ball

'AI kicking variables'
var dribblestrengthAI = 12
var shootingstrengthAI = 50
var arcHeightAI = 6
var arcHeightAI_longer = 10
var passStrength = 35

var enemy_close : bool = false


func _physics_process(_delta: float) -> void:
	if is_colliding():
		var obj = get_collision_count()
		for i in range(obj):
			var colliding_object = get_collider(i)
			ball = colliding_object
			if colliding_object.has_method("_kickball"):
				if kickCounter >= 3 || enemy_close:
					_pass(colliding_object)
					return
				if opposing_team_player.target_reached and not opposing_team_player.in_range and can_kick:
					print("kick")
					_kick_towards_goal_AI(colliding_object)
					can_kick = false
					kick_timer.start()
				if opposing_team_player.target_reached and opposing_team_player.in_range:
					print("shoot")
					_shoot_for_goal(opposing_team_player, colliding_object)


'the can kick variable simply makes it so the ai doesnt spam kick when in range'
func _on_kick_timer_timeout() -> void:
	can_kick = true

func _kick_towards_goal_AI(object):
	var y = randi_range(-3, 3)
	var x = randi_range(-30, 30) # 30 / 30 works too, originally used -9 / 9
	var random_goal_pos
	if opposing_team_player.home == false:
		random_goal_pos = Vector3(Global.home_goal_pos.x + (x), Global.home_goal_pos.y + (y), Global.home_goal_pos.z)
		object.apply_impulse((random_goal_pos - global_position).normalized() * dribblestrengthAI)
		kickCounter += 1
	elif opposing_team_player.home == true:
		random_goal_pos = Vector3(Global.away_goal_pos.x + (x), Global.away_goal_pos.y + (y), Global.away_goal_pos.z)
		object.apply_impulse((random_goal_pos - global_position).normalized() * dribblestrengthAI)
		kickCounter += 1

'change this so the thing doesnt break if the there is no teammates nearby'
func _pass(object):
	var best_pass 
	for i in teammates:
		if global_position.distance_to(i.global_position) <= 30:
			best_pass = i.global_position
			break
	if best_pass == null:
		kickCounter = 0  # I don't know why but this fixed the passing issue now it will pass to the player be careful
		return
	object.apply_impulse((best_pass - global_position).normalized() * passStrength)
	kickCounter = 0

'the extra y impulse helps the ball get more air and the second use case is for when the player is closer'
func _shoot_for_goal(enemy, object):
	var y = randi_range(2, 3)
	var x = randi_range(-9, 9)
	var random_goal_pos 
	if opposing_team_player.home == false:
		random_goal_pos = Vector3(Global.home_goal_pos.x + (x), Global.home_goal_pos.y + (y), Global.home_goal_pos.z)
	elif opposing_team_player.home == true:
		random_goal_pos = Vector3(Global.away_goal_pos.x + (x), Global.away_goal_pos.y + (y), Global.away_goal_pos.z)
	var distance_from_goal = abs(random_goal_pos.z) - abs(enemy.position.z)
	if random_goal_pos.y > 2 and abs(distance_from_goal) > 25:
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * shootingstrengthAI)
		object.apply_impulse(enemy.basis.y * arcHeightAI_longer)
		print("high shot")
		Global.kick_target.emit(random_goal_pos)
	elif random_goal_pos.y > 2:
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * shootingstrengthAI)
		object.apply_impulse(enemy.basis.y * arcHeightAI)
	else:
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * shootingstrengthAI)



func _on_enemy_players_body_entered(body: Node3D) -> void:
	if body not in teammates and not opposing_team_player:
		enemy_close = true
		print("enemy is range")
		

func _on_enemy_players_body_exited(body: Node3D) -> void:
	if body not in teammates and not opposing_team_player:
		enemy_close = false
		print("enemy out of range")
		
