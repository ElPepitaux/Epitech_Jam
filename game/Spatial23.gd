extends Spatial

var count = Count

onready var map = get_parent()
onready var boss = preload("res://All_Enemy/Slime.tscn")

func _process(delta):
	if count.enemy_died >= count.kill_goal:
		var Boss = boss.instance()
		Boss.global_transform = global_transform
		map.add_child(Boss)
		queue_free()
