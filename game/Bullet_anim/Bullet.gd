extends KinematicBody

var velocity = Vector3.ZERO

var GRAVITY = 10

onready var collision_shape = $CollisionShape
onready var animation_player = $Explosion/AnimationPlayer
onready var explosion = $Explosion

func _ready():
	explosion.visible = false

func _physics_process(delta):
	velocity.y -= GRAVITY * delta
	print(explosion.is_visible_in_tree())
	
	if is_on_floor():
		explosion.visible = true
		animation_player.play("Icosphere001Action")
	
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(45))
