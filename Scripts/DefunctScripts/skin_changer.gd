extends Node3D

var counter = 1

@onready var skin: MeshInstance3D = $Skin
@onready var skin_2: MeshInstance3D = $Skin2
@onready var skin_3: MeshInstance3D = $Skin3
@onready var skin_4: MeshInstance3D = $Skin4
@onready var skin_5: MeshInstance3D = $Skin5
@onready var skin_6: MeshInstance3D = $Skin6

func switch_skins():
	counter += 1
	if counter > 6:
		counter = 0
		switch_skins()
	else:
		if counter == 1:
			skin.visible = true
			skin_2.visible = false
			skin_3.visible = false
			skin_4.visible = false
			skin_5.visible = false
			skin_6.visible = false
		elif counter == 2:
			skin.visible = false
			skin_2.visible = true
			skin_3.visible = false
			skin_4.visible = false
			skin_5.visible = false
			skin_6.visible = false
		elif counter == 3:
			skin.visible = false
			skin_2.visible = false
			skin_3.visible = true
			skin_4.visible = false
			skin_5.visible = false
			skin_6.visible = false
		elif counter == 4:
			skin.visible = false
			skin_2.visible = false
			skin_3.visible = false
			skin_4.visible = true
			skin_5.visible = false
			skin_6.visible = false
		elif counter == 5:
			skin.visible = false
			skin_2.visible = false
			skin_3.visible = false
			skin_4.visible = false
			skin_5.visible = true
			skin_6.visible = false
		elif counter == 6:
			skin.visible = false
			skin_2.visible = false
			skin_3.visible = false
			skin_4.visible = false
			skin_5.visible = false
			skin_6.visible = true
