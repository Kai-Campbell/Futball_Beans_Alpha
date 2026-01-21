extends Node3D

@onready var time: Node3D = $Scoreboard1/Time
@onready var time2: Node3D = $Scoreboard2/Time
@onready var home_goal_center: Node3D = $HomeGoalCenter
@onready var enemy_goal_center: Node3D = $EnemyGoalCenter




func _init() -> void:
	Global.school_gym = self
	
func _ready() -> void:
	Global.home_goal_pos = home_goal_center.position
	Global.away_goal_pos = enemy_goal_center.position
	time.start_countdown()
	time2.start_countdown()
