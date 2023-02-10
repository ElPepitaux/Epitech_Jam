extends Spatial


func _input(event):
	if Input.is_action_just_pressed("quit"): # !!!!!!!! temporaire !!!!!!
		get_tree().quit()
