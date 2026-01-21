extends Control


func _on_yes_exit_pressed() -> void:
	get_tree().quit()
	
func _on_button_dont_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/MainMenu.tscn")
