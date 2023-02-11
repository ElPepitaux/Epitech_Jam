extends KinematicBody

onready var animation = $spider/AnimationPlayer
onready var playerdection = $player_dection
onready var hitbox = $Hitbox
onready var wander = $Wander
onready var stats = $Stats
onready var softcollision = $softCollision
onready var lot_2 = preload("res://items/Ammo.tscn")
onready var map = get_parent()

enum {
	IDLE,
	WANDER,
	CHASE
}

var stat = IDLE

var attack_player = false
var gravity = -14
var velocity = Vector3.ZERO
var FRICTION = 20
var SPRINT = 10
var WALK = 5
var ACCEL = 15

func _ready():
	randomize()
	stat = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match stat:
		IDLE:
			animation.play("Idle")
			velocity = velocity.move_toward(Vector3.ZERO, delta * FRICTION)
			seek_player()
			
			if wander.get_time_left() == 0:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(rand_range(5, 10))
			
		WANDER:
			seek_player()
			animation.play("Walk")
			if wander.get_time_left() == 0:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(rand_range(5, 10))
				
			var direction = global_transform.origin.direction_to(wander.target_position)
			velocity = velocity.move_toward(direction * WALK, ACCEL * delta)
			look_at(wander.target_position, Vector3.UP)
			rotation_degrees.y += 180
			if global_transform.origin.distance_to(wander.target_position) <= 4:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(rand_range(1, 3))

		CHASE:
			animation.play("Walk")
			var player = playerdection.player
			if player != null:
				look_at(player.global_transform.origin, Vector3.UP)
				rotation_degrees.y += 180
				var direction = global_transform.origin.direction_to(player.get_global_transform().origin)
				
				velocity = velocity.move_toward(direction * SPRINT, delta * ACCEL)
			else:
				stat = IDLE
			
	velocity.y += gravity * delta
			
	if softcollision.is_colliding():
		velocity += softcollision.get_push_vector()
	velocity = move_and_slide(velocity)
	
func seek_player():
	if playerdection.can_see_player():
		stat = CHASE

func pick_random_state(list_state):
	list_state.shuffle()
	return list_state.pop_front()

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	
func _on_Stats_no_health():
	stat = null
	velocity = Vector3.ZERO
	animation.play("Die", 0.5)
	
func die_animation_finish():
	var ammo = lot_2.instance()
	ammo.global_transform = global_transform
	print(ammo.global_transform.origin)
	map.add_child(ammo)
	queue_free()
	

