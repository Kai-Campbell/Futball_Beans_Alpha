extends Node3D

@onready var home_goal_center: Node3D = $HomeGoalCenter
@onready var away_goal_center: Node3D = $AwayGoalCenter
@onready var time: Node3D = $Scoreboard1/Time
@onready var time_2: Node3D = $Scoreboard2/Time
@onready var ball: RigidBody3D = $Ball



'stadium geometry'
@onready var animation_player_away: AnimationPlayer = $"Goalie Area Away/AnimationPlayer"
@onready var animation_player_home: AnimationPlayer = $"Goalie Area Home/AnimationPlayer"


func _init() -> void:
	Global.Stadium1 = self
	Global.in_possession_away = false
	Global.in_possession_home = false

func _ready() -> void:
	Global.away_goal_pos = away_goal_center.position
	Global.home_goal_pos = home_goal_center.position
	Global.ball_pos = ball.position
	time.start_countdown()
	time_2.start_countdown()


func _on_away_goal_close_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		animation_player_away.play("Move Back")

func _on_away_goal_close_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		animation_player_away.play_backwards("Move Back")

func _on_home_goal_close_body_entered(body: Node3D) -> void:
	if body.is_in_group("OpposingTeam"):
		if body.play_type == 0:
			animation_player_home.play("Move Back")

func _on_home_goal_close_body_exited(body: Node3D) -> void:
	if body.is_in_group("OpposingTeam"):
		if body.play_type == 0:
			animation_player_home.play_backwards("Move Back")
