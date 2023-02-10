extends KinematicBody

onready var animation = $spider/AnimationPlayer
onready var playerdection = $player_dection


enum {
	IDLE,
	WANDER,
	CHASE
}

var stat = IDLE

var gravity = -14
var velocity = Vector3.ZERO
var FRICTION = 20

func _ready():
	pass

func _physics_process(delta):
	match stat:
		IDLE:
			velocity = velocity.move_toward(Vector3.ZERO, delta * FRICTION)
			seek_player()
			
		WANDER:
			seek_player()
		CHASE:
			var player = playerdection.player
			if player != null:
				look_at(Vector3(player.translation.x + 180, player.translation.y, player.translation.z + 360), Vector3.UP)
				var direction = global_transform.origin.direction_to(player.get_global_transform().origin)
				velocity = velocity.move_toward(direction * 5, delta * 10)
			else:
				stat = IDLE
			
	velocity = move_and_slide(velocity)
	
func seek_player():
	if playerdection.can_see_player():
		stat = CHASE

func pick_random_state(list_state):
	list_state.shuffle()
	return list_state.pop(0)

func _on_HurtBox_area_entered(area):
	pass
