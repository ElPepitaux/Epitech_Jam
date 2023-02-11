extends Spatial

onready var stats = $Stats
onready var Enemy = preload("res://All_Enemy/enemy.tscn")
onready var map = get_parent()
onready var lot_1 = preload("res://items/Heal.tscn")
onready var time = $Timer

var spawn = false

func _ready():
	set_timer(randi() % 240)
	
func _process(delta):
	if spawn:
		spawn = false
		var enemy = Enemy.instance()
		enemy.global_transform = global_transform
		map.add_child(enemy)
		set_timer(randi() % 240)

func set_timer(duration):
	time.start(duration)

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	if stats.health % 2 == 0:
		var enemy = Enemy.instance()
		enemy.global_transform = global_transform
		map.add_child(enemy)

func _on_Stats_no_health():
	var health = lot_1.instance()
	health.global_transform = global_transform
	map.add_child(health)
	queue_free()

func _on_Timer_timeout():
	spawn = true
