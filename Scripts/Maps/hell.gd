extends Node3D

@onready var away_goal_center: Node3D = $AwayGoalCenter
@onready var home_goal_center: Node3D = $HomeGoalCenter
@onready var ball: RigidBody3D = $Ball

func _init() -> void:
	Global.hell = self

func _ready() -> void:
	Global.home_goal_pos = home_goal_center.position
	Global.away_goal_pos = away_goal_center.position
	Global.ball_pos = ball.position
