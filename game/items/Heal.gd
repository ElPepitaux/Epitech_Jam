extends Spatial

var player_stats = PlayerStats

func _on_HurtBox_area_entered(area):
	player_stats.health += 2
	print("oui")
	queue_free()
