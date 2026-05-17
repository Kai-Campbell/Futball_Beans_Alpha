extends Control

# Buttons of the menu

func _ready() -> void:
	GlobalMusic.play_menu_music()

func _on_StoryMode_pressed() -> void:
	print("Coming Soon")

func _on_QuickGame_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/character_custom.tscn")

func _on_Settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu_options.tscn")

func _on_Exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/are_you_sure.tscn")
