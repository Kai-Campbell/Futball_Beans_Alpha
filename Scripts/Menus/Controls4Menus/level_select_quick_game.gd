extends OptionButton
var map = 1
var top_z = 5
var bottom_z = 0
@onready var map_1: TextureRect = $"../Control/Map1"
@onready var map_2: TextureRect = $"../Control/Map2"
@onready var map_3: TextureRect = $"../Control/Map3"
@onready var map_4: TextureRect = $"../Control/Map4"
@onready var map_5: TextureRect = $"../Control/Map5"

# This sets the map being played and the image being displayed
func _on_item_selected(index: int) -> void:
	var options = [1, 2, 3, 4, 5]
	map = options[index]
	if map == 1:
		map_1.z_index = top_z
		map_2.z_index = bottom_z
		map_3.z_index = bottom_z
		map_4.z_index = bottom_z
		map_5.z_index = bottom_z
	elif map == 2:
		map_1.z_index = bottom_z
		map_2.z_index = top_z
		map_3.z_index = bottom_z
		map_4.z_index = bottom_z
		map_5.z_index = bottom_z
	elif map == 3:
		map_1.z_index = bottom_z
		map_2.z_index = bottom_z
		map_3.z_index = top_z
		map_4.z_index = bottom_z
		map_5.z_index = bottom_z
	elif map == 4:
		map_1.z_index = bottom_z
		map_2.z_index = bottom_z
		map_3.z_index = bottom_z
		map_4.z_index = top_z
		map_5.z_index = bottom_z
	elif map == 5:
		map_1.z_index = bottom_z
		map_2.z_index = bottom_z
		map_3.z_index = bottom_z
		map_4.z_index = bottom_z
		map_5.z_index = top_z

func _on_play_pressed() -> void:
	if map == 1:
		get_tree().change_scene_to_file("res://Scenes/Maps/Stadium1.tscn")
	elif map == 2:
		get_tree().change_scene_to_file("res://Scenes/Maps/sunday_league.tscn")
	elif map == 3:
		get_tree().change_scene_to_file("res://Scenes/Maps/Beach.tscn")
	elif map == 4:
		get_tree().change_scene_to_file("res://Scenes/Maps/school.tscn")
	elif map == 5:
		get_tree().change_scene_to_file("res://Scenes/Maps/hell.tscn")
