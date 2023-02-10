extends KinematicBody

onready var animation = $spider/AnimationPlayer
onready var playerdection = $player_dection

enum {
	IDLE,
	WANDER,
	CHASE
}

var stat = IDLE

var velocity = Vector3.ZERO

func _physics_process(delta):
	match stat:
		IDLE:
			seek_player()
		WANDER:
			seek_player()
		CHASE:
			print("oui")
			pass
	
func seek_player():
	if playerdection.can_see_player():
		stat = CHASE
