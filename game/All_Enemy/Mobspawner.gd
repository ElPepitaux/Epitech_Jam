extends Spatial

onready var stats = $Stats
onready var Enemy = preload("res://All_Enemy/enemy.tscn")
onready var map = get_parent()
onready var lot_1 = preload("res://items/Heal.tscn")

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	if stats.health % 2 == 0:
		var enemy = Enemy.instance()
		enemy.global_transform = global_transform
		map.add_child(enemy)


func _on_Stats_no_health():
	print(rand_range(1, 2))
	var health = lot_1.instance()
	health.global_transform = global_transform
	map.add_child(health)
	queue_free()
