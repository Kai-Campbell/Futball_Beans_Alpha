extends ShapeCast3D


func _physics_process(_delta: float) -> void:
	if is_colliding():
		var obj = get_collision_count()
		for i in range(obj):
			var colliding_object = get_collider(i)
			if colliding_object.has_method("_kickball"):
				if Input.is_action_just_pressed("kick"):
					colliding_object._kickball(get_parent().get_parent())
				if Input.is_action_pressed("stop_dribble"):
					colliding_object.linear_velocity = colliding_object.linear_velocity.move_toward(Vector3.ZERO, 0.25)
				if Input.is_action_just_pressed("Arc"):
					colliding_object._arcShotball(get_parent())
				if Input.is_action_just_pressed("Shoot"):
					colliding_object._shootball(get_parent())
