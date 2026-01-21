extends CollisionShape3D
'''
func _physcics_process(delta: float):
	if is_colliding():
		var obj = get_collider()
		if obj.is_in_group("Ball"):
			if Input.is_action_just_pressed("Volley"):
				obj.add_central_force(Vector3(0, 0, -50) * -transform.basis.z)
'''
