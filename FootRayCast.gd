extends RayCast3D

'''
This script was used for shooting with the ray cast. We now use the
Shapecast for better player expereince. This is here if needed.
'''

'''
var dribblestrength = 1.0 #Not in use
var kickstrength = 15.0
const VOLLEYSPEED = 35.0


func _physics_process(delta: float) -> void:
	if is_colliding():
		var obj = get_collider()
		if obj.has_method("_kickball"):
			if Input.is_action_just_pressed("kick"):
				obj._kickball(get_parent())
			if Input.is_action_pressed("Volley"): #when holding, launches ball (good for kicks)
				obj._arcShotball(get_parent())
			if Input.is_action_pressed("dribble"):
				obj._dribbleball(get_parent())
		
		
	'''
