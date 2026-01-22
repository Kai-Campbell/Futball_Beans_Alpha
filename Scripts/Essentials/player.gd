extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var camera_3d: Camera3D = $Head/Camera3D
#@onready var foot: CollisionShape3D = $Foot #Not in use
#@onready var FootRayCast3D: RayCast3D = $RayCast3D #Not in use
#@onready var FootRayCast: RayCast3D = $RayCastFoot #Not in use

'current direction variable is used for dribbling the ball in a direction the player is moving'
var current_direction

var speed
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const RUN_SPEED = 10
var sensitivity = 0.005
var dashSpeed = 50

var canDash = true
var isDashing = false


'''
These variables are not used in this script, they are in the foot ray cast script. These
were used for kicking the ball when it was based on collision. It can be re-enabled if
needed.
var dribblestrength = 1.0 #Not in use
var kickstrength = 15.0
const VOLLEYSPEED = 35.0
'''

func _init() -> void:
	Global.player = self
	
func _ready():
	set_custom_character()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func set_custom_character():
	$Skin.set_surface_override_material(0, Global.skins_array[Global.current_skin])
	$Shirt.set_surface_override_material(0, Global.shirts_array[Global.current_shirt])
	$Pants.set_material(Global.pants_array[Global.current_pants])
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera_3d.rotate_x(-event.relative.y * sensitivity)
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-60), deg_to_rad(70))
		
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("sprint"):
		speed = RUN_SPEED
	else:
		speed = SPEED
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	current_direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		if not isDashing and canDash:
			if Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				print("header")
				isDashing = true
				canDash = false
				velocity.x = direction.x * (SPEED * dashSpeed) + delta
				velocity.z = direction.z * (SPEED * dashSpeed) + delta
				$DashTimer.start()

	move_and_slide()

	
	'''
	This is the old way of kicking the ball that worked on player collision.
	It is no longer in use as the raycast is better, but it is here if needed.
	
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody3D:
			if Input.is_action_just_pressed("kick"):
				col.get_collider().apply_central_impulse(-col.get_normal() * kickstrength)
			if Input.is_action_just_pressed("Volley"):
				col.get_collider().apply_central_impulse(-col.get_normal() * -transform.basis.y * 100)
				col.get_collider().apply_central_impulse(-col.get_normal() * kickstrength)
			if Input.is_action_just_pressed("dribble"):
				col.get_collider().apply_central_impulse(-col.get_normal() * kickstrength / 2)
				
	'''

'''
This section is the character customizer. It is no longer in use
for streamlining and working with global scripts. This way worked
kind of, but didn't work with the global script and could not 
be expanded so it was scrapped.

'Character Customization'
@onready var skin_changer: Node3D = $SkinChanger
@onready var shirt_changer: Node3D = $"Shirt Changer"
@onready var pants_changer: Node3D = $"Pants Changer"


func change_skin():
	skin_changer.switch_skins()

func change_shirt():
	shirt_changer.switch_shirts()

func change_pants():
	pants_changer.switch_pants()
'''

func get_direction():
	return current_direction

func _on_dash_timer_timeout() -> void:
	isDashing = false
	canDash = true
