extends ShapeCast3D

@onready var shape_cast_3d: ShapeCast3D = $"."
@onready var hands: Node3D = $"../Hands"
@onready var goalie: CharacterBody3D = $".."


func _physics_process(delta: float) -> void:
	if is_colliding():
		var obj = get_collision_count()
		for i in range(obj):
			var colliding_object = get_collider(i)
			if colliding_object.has_method("_kickball"):
				var kick_to
				if goalie.home == false:
					kick_to = Global.home_goal_pos
				elif goalie.home == true:
					kick_to = Global.away_goal_pos
				
				colliding_object.apply_impulse((kick_to - goalie.position).normalized() * 5)
				#var last_pos = colliding_object.position
				#colliding_object.position = hands.global_position
				#await get_tree().create_timer(3).timeout
