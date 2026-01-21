extends Node3D

var counter = 1
@onready var pants: CSGMesh3D = $Pants
@onready var pants_2: CSGMesh3D = $Pants2
@onready var pants_3: CSGMesh3D = $Pants3
@onready var pants_4: CSGMesh3D = $Pants4
@onready var pants_5: CSGMesh3D = $Pants5
@onready var pants_6: CSGMesh3D = $Pants6


func switch_pants():
	counter += 1
	if counter > 6:
		counter = 0
		switch_pants()
	else:
		if counter == 1:
			pants.visible = true
			pants_2.visible = false
			pants_3.visible = false
			pants_4.visible = false
			pants_5.visible = false
			pants_6.visible = false
		elif counter == 2:
			pants.visible = false
			pants_2.visible = true
			pants_3.visible = false
			pants_4.visible = false
			pants_5.visible = false
			pants_6.visible = false
		elif counter == 3:
			pants.visible = false
			pants_2.visible = false
			pants_3.visible = true
			pants_4.visible = false
			pants_5.visible = false
			pants_6.visible = false
		elif counter == 4:
			pants.visible = false
			pants_2.visible = false
			pants_3.visible = false
			pants_4.visible = true
			pants_5.visible = false
			pants_6.visible = false
		elif counter == 5:
			pants.visible = false
			pants_2.visible = false
			pants_3.visible = false
			pants_4.visible = false
			pants_5.visible = true
			pants_6.visible = false
		elif counter == 6:
			pants.visible = false
			pants_2.visible = false
			pants_3.visible = false
			pants_4.visible = false
			pants_5.visible = false
			pants_6.visible = true
