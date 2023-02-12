extends Spatial

onready var boss = preload("res://All_Enemy/Slime.tscn")
onready var map = get_parent()

var count = Count

func _process(delta):
	if count.enemy_died > 2:
		queue_free()
