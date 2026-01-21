extends Node

@onready var player: CharacterBody3D = $"Player Viewer/SubViewportContainer/SubViewport/Camera3D/Player"


'Maps'
@onready var Stadium1
@onready var hell
@onready var sunday_league
@onready var Beach
@onready var school_gym

var homeScore = 0
var awayScore = 0

var current_skin = 0
var current_shirt = 0
var current_pants = 0

var skins_array = []
var shirts_array = []
var pants_array = []

var home_goal_pos
var away_goal_pos
var ball_pos

var scored : bool
var in_possession_away : bool
var in_possession_home : bool

''' The below section handels the character customization '''

func _ready() -> void:
	get_data()
	
func get_data():
	for file in ResourceLoader.list_directory("res://Assets/Player Customizations/Clothes/Pants/"):
		if file.contains(".import") or file.contains(".png"):
			continue
		pants_array.append(load("res://Assets/Player Customizations/Clothes/Pants/" + file))
	
	for file in ResourceLoader.list_directory("res://Assets/Player Customizations/Clothes/Shirts/"):
		if file.contains(".import") or file.contains(".png"):
			continue
		shirts_array.append(load("res://Assets/Player Customizations/Clothes/Shirts/" + file))
	
	for file in ResourceLoader.list_directory("res://Assets/Player Customizations/Skins/"):
		if file.contains(".import") or file.contains(".png"):
			continue
		skins_array.append(load("res://Assets/Player Customizations/Skins/" + file))
		
