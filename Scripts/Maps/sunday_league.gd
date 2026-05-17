extends Node3D

'level geometry'
@onready var away_goal_center: Node3D = $"Away Goal Center"
@onready var home_goal_center: Node3D = $"Home Goal Center"
@onready var animation_player_home: AnimationPlayer = $"Goalie Area Home/AnimationPlayer"


@onready var ball: RigidBody3D = $Ball


func _init() -> void:
	Global.sunday_league = self

func _ready() -> void:
	Global.away_goal_pos = away_goal_center.position
	Global.home_goal_pos = home_goal_center.position
	Global.ball_pos = ball.position
	GlobalMusic.stop_music()
