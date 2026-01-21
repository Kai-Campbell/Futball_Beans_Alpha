extends Node3D

var counter = 1

@onready var shirt: MeshInstance3D = $Shirt
@onready var shirt_2: MeshInstance3D = $Shirt2
@onready var shirt_3: MeshInstance3D = $Shirt3
@onready var shirt_4: MeshInstance3D = $Shirt4
@onready var shirt_5: MeshInstance3D = $Shirt5
@onready var shirt_6: MeshInstance3D = $Shirt6


func switch_shirts():
	counter += 1
	if counter > 6:
		counter = 0
		switch_shirts()
	else:
		if counter == 1:
			shirt.visible = true
			shirt_2.visible = false
			shirt_3.visible = false
			shirt_4.visible = false
			shirt_5.visible = false
			shirt_6.visible = false
		elif counter == 2:
			shirt.visible = false
			shirt_2.visible = true
			shirt_3.visible = false
			shirt_4.visible = false
			shirt_5.visible = false
			shirt_6.visible = false
		elif counter == 3:
			shirt.visible = false
			shirt_2.visible = false
			shirt_3.visible = true
			shirt_4.visible = false
			shirt_5.visible = false
			shirt_6.visible = false
		elif counter == 4:
			shirt.visible = false
			shirt_2.visible = false
			shirt_3.visible = false
			shirt_4.visible = true
			shirt_5.visible = false
			shirt_6.visible = false
		elif counter == 5:
			shirt.visible = false
			shirt_2.visible = false
			shirt_3.visible = false
			shirt_4.visible = false
			shirt_5.visible = true
			shirt_6.visible = false
		elif counter == 6:
			shirt.visible = false
			shirt_2.visible = false
			shirt_3.visible = false
			shirt_4.visible = false
			shirt_5.visible = false
			shirt_6.visible = true
