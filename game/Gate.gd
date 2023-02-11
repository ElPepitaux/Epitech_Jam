extends Spatial

var count = Count

func _process(delta):
	if count.enemy_died > 35:
		queue_free()
