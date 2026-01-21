extends OptionButton

# Changes the resolution scaling for performance

func _on_item_selected(index: int) -> void:
	var options = [1.0, 0.75, 0.5, 0.20]
	var value = options[index]
	get_tree().root.scaling_3d_scale = value
