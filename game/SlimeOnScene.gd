extends KinematicBody

onready var playerdection = $player_dection
onready var hitbox = $Hitbox
onready var wander = $Wander
onready var stats = $Stats
onready var animation = $AnimationPlayer

enum {
	IDLE,
	WANDER,
	CHASE
}

var boss = Count
var stat = IDLE

var attack_player = false
var gravity = -90
var velocity = Vector3.ZERO
var FRICTION = 5
var SPRINT = 15
var WALK = 6
var ACCEL = 15
var count = Count

func _ready():
	randomize()
	stat = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match stat:
		IDLE:
			animation.play("Slime_IDLE")
			velocity = Vector3.ZERO
			seek_player()
			
			if wander.get_time_left() == 0:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(rand_range(5, 10))
			
		WANDER:
			seek_player()
			animation.play("Slime_WALK")
			if wander.get_time_left() == 0:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(rand_range(5, 10))
				
			var direction = global_transform.origin.direction_to(wander.target_position)
			velocity = velocity.move_toward(direction * WALK, ACCEL * delta)
			look_at(wander.target_position, Vector3.UP)
			rotation_degrees.y += 180
			if global_transform.origin.distance_to(wander.target_position) <= 4:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(rand_range(5, 10))

		CHASE:
			animation.play("Slime_WALK")
			var player = playerdection.player
			if player != null:
				look_at(player.global_transform.origin, Vector3.UP)
				rotation_degrees.y += 180
				var direction = global_transform.origin.direction_to(player.get_global_transform().origin)
				
				velocity = velocity.move_toward(direction * SPRINT, ACCEL * delta)
			else:
				stat = IDLE
			
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity, Vector3.UP)
	
func seek_player():
	if playerdection.can_see_player():
		stat = CHASE

func pick_random_state(list_state):
	list_state.shuffle()
	return list_state.pop_front()

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	
func slim_animation_finished():
	boss.boss = true
	queue_free()

func _on_Stats_no_health():
	stat = null
	velocity = Vector3.ZERO
	animation.play("Slime_DEAD", 0.5)
