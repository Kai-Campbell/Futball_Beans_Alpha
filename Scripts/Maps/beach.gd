extends Node3D

@onready var ball: RigidBody3D = $Ball


func _init() -> void:
	Global.Beach = self

func _ready() -> void:
	Global.ball_pos = ball.position
	GlobalMusic.stop_music()
