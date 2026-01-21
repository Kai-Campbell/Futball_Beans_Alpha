extends Control


func _on_timer_timeout() -> void:
	$TextureProgressBar.value +=1
