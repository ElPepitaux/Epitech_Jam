extends Area

var player = null

func can_see_player():
	return player != null

func _on_player_dection_body_entered(body):
	player = body

func _on_player_dection_body_exited(body):
	player = null
