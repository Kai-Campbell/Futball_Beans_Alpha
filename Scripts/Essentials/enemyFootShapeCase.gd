extends ShapeCast3D

@onready var opposing_team_player: CharacterBody3D = $"../.."
var can_kick = true
@onready var kick_timer: Timer = $"../../KickTimer"

'AI kicking variables'
var dribblestrengthAI = 12
var shootingstrengthAI = 50
var arcHeightAI = 6
var arcHeightAI_longer = 10

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var obj = get_collision_count()
		for i in range(obj):
			var colliding_object = get_collider(i)
			if colliding_object.has_method("_kickball"):
				if opposing_team_player.target_reached and not opposing_team_player.in_range and can_kick:
					print("kick")
					_kick_towards_goal_AI(opposing_team_player, colliding_object)
					can_kick = false
					kick_timer.start()
				if opposing_team_player.target_reached and opposing_team_player.in_range:
					print("shoot")
					_shoot_for_goal(opposing_team_player, colliding_object)
					

'the can kick variable simply makes it so the ai doesnt spam kick when in range'
func _on_kick_timer_timeout() -> void:
	can_kick = true

func _kick_towards_goal_AI(enemy, object):
	var y = randi_range(-3, 3)
	var x = randi_range(-30, 30) # 30 / 30 works too, originally used -9 / 9
	var random_goal_pos
	if get_parent().get_parent().is_in_group("OpposingTeam"):
		random_goal_pos = Vector3(Global.home_goal_pos.x + (x), Global.home_goal_pos.y + (y), Global.home_goal_pos.z)
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * dribblestrengthAI)
	elif get_parent().get_parent().is_in_group("PlayerTeam"):
		random_goal_pos = Vector3(Global.away_goal_pos.x + (x), Global.away_goal_pos.y + (y), Global.away_goal_pos.z)
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * dribblestrengthAI)

'the extra y impulse helps the ball get more air and the second use case is for when the player is closer'
func _shoot_for_goal(enemy, object):
	var y = randi_range(-3, 3)
	var x = randi_range(-9, 9)
	var random_goal_pos 
	if get_parent().get_parent().is_in_group("OpposingTeam"):
		random_goal_pos = Vector3(Global.home_goal_pos.x + (x), Global.home_goal_pos.y + (y), Global.home_goal_pos.z)
	elif get_parent().get_parent().is_in_group("PlayerTeam"):
		random_goal_pos = Vector3(Global.away_goal_pos.x + (x), Global.away_goal_pos.y + (y), Global.away_goal_pos.z)
	var distance_from_goal = abs(random_goal_pos.z) - abs(enemy.position.z)
	if random_goal_pos.y > 2 and abs(distance_from_goal) > 25:
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * shootingstrengthAI)
		object.apply_impulse(enemy.basis.y * arcHeightAI_longer)
		print("high shot")
	elif random_goal_pos.y > 2:
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * shootingstrengthAI)
		object.apply_impulse(enemy.basis.y * arcHeightAI)
	else:
		object.apply_impulse((random_goal_pos - enemy.position).normalized() * shootingstrengthAI)
