extends Spatial

export (int) var wander_range

onready var time = $Timer

onready var start_position = global_transform
onready var target_position = global_transform

func _ready():
	updata_taget_position()

func updata_taget_position():
	var target_vector = Vector3(rand_range(-wander_range, wander_range), 0, rand_range(-wander_range, wander_range))
	target_position = start_position.origin + target_vector
	
func get_time_left():
	return time.time_left
	
func start_timer_wander(duration):
	time.start(duration)

func _on_Timer_timeout():
	updata_taget_position()
