extends Node3D

@onready var animated_sprite_3d_5: AnimatedSprite3D = $AnimatedSprite3D5
@onready var animated_sprite_3d_4: AnimatedSprite3D = $AnimatedSprite3D4
@onready var animated_sprite_3d_3: AnimatedSprite3D = $AnimatedSprite3D3
@onready var animated_sprite_3d_2: AnimatedSprite3D = $AnimatedSprite3D2
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D

func _physics_process(delta: float) -> void:
	if Global.scored == true:
		animated_sprite_3d.set_speed_scale(2.5)
		animated_sprite_3d_2.set_speed_scale(2.5)
		animated_sprite_3d_3.set_speed_scale(2.5)
		animated_sprite_3d_4.set_speed_scale(2.5)
		animated_sprite_3d_5.set_speed_scale(2.5)
		$CheerTimer.start()


func _on_cheer_timer_timeout() -> void:
	animated_sprite_3d.set_speed_scale(1.0)
	animated_sprite_3d_2.set_speed_scale(1.0)
	animated_sprite_3d_3.set_speed_scale(1.0)
	animated_sprite_3d_4.set_speed_scale(1.0)
	animated_sprite_3d_5.set_speed_scale(1.0)
