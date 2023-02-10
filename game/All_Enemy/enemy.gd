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

func _ready():
	pass

func _physics_process(delta):
	match stat:
		IDLE:
			seek_player()
			
		WANDER:
			seek_player()
		CHASE:
			var player = playerdection.player
			var direction = global_transform.origin.direction_to(player.get_global_transform().origin)
			velocity = velocity.move_toward(direction * 5, delta * 10)
			
			
	velocity = move_and_slide(velocity)
	
func seek_player():
	if playerdection.can_see_player():
		stat = CHASE

func pick_random_state(list_state):
	list_state.shuffle()
	return list_state.pop(0)

func _on_HurtBox_area_entered(area):
	pass
