extends Control

@onready var player: CharacterBody3D = $"Player Viewer/SubViewportContainer/SubViewport/Camera3D/Player"


func _ready():
	connect_signals()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	'this code is needed because of the subviewport hiding the mouse'

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/MainMenu.tscn")


func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/quick_game_selection.tscn")
	
	
''' This whole section controls the players customizations '''
func connect_signals() -> void:
	%SkinBack.connect("pressed", skin_back)
	%SkinNext.connect("pressed", skin_next)
	%ShirtBack.connect("pressed", shirt_back)
	%ShirtNext.connect("pressed", shirt_next)
	%PantsBack.connect("pressed", pants_back)
	%PantsNext.connect("pressed", pants_next)
	
func skin_back() -> void:
	Global.current_skin = (Global.current_skin - 1) % Global.skins_array.size()
	%SkinC.set_surface_override_material(0, Global.skins_array[Global.current_skin])
	
func skin_next() -> void:
	Global.current_skin = (Global.current_skin + 1) % Global.skins_array.size()
	%SkinC.set_surface_override_material(0, Global.skins_array[Global.current_skin])
	
func shirt_back() -> void:
	Global.current_shirt = (Global.current_shirt - 1) % Global.shirts_array.size()
	%Shirt2.set_surface_override_material(0, Global.shirts_array[Global.current_shirt])

func shirt_next() -> void:
	Global.current_shirt = (Global.current_shirt + 1) % Global.shirts_array.size()
	%Shirt2.set_surface_override_material(0, Global.shirts_array[Global.current_shirt])
	
func pants_back() -> void:
	Global.current_pants = (Global.current_pants - 1) % Global.pants_array.size()
	%PantsC.set_material(Global.pants_array[Global.current_pants])

func pants_next() -> void:
	Global.current_pants = (Global.current_pants + 1) % Global.pants_array.size()
	%PantsC.set_material(Global.pants_array[Global.current_pants])
