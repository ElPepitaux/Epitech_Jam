extends Spatial

var player_stats = PlayerStats

func _on_HurtBox_body_entered(body):
	if body.get_name() == "Player":
		player_stats.health += 2
		if player_stats.health > 10:
			player_stats.health = 10
		queue_free()

