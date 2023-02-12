extends Spatial

onready var boss = preload("res://All_Enemy/Slime.tscn")
onready var map = get_parent()

var count = Count

func _process(delta):
	if count.enemy_died >= count.kill_goal: # modifier la valeur dans count
		queue_free()
