extends CanvasLayer
@onready var options_menu: Panel = $"Options Menu"
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var paused: Label = $Paused

# Pause Menu 

func _ready():
	options_menu.visible = false
	visible = false
	v_box_container.visible = true
	get_tree().paused = false
	paused.visible = true


func _input(_event: InputEvent):
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		else:
			visible = true
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _on_settings_pressed() -> void:
	paused.visible = false
	v_box_container.visible = false
	options_menu.visible = true
	
func _on_exit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/MainMenu.tscn")

func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_options_back_pressed() -> void:
	paused.visible = true
	v_box_container.visible = true
	options_menu.visible = false
