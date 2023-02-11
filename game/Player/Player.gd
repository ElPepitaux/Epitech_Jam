extends KinematicBody

onready var cam = $Camera
onready var spawn = $Right/RightArm/Weapon/Spawn
onready var anim = $AnimationPlayer
onready var cast = $Camera/Cast
onready var end = $Camera/End
onready var arm = $Right/RightArm
onready var bull = preload("res://Player/Chouchou.tscn")

export var speed = 5
export var acceleration = 8
export var sensitivity = 0.2
export var max_angle = 90
export var min_angle = -80
export var gravity = 90
export var jump = 15
export var max_jumps = 2

var stat = PlayerStats
var look_rot = Vector3.ZERO
var arm_rot = Vector3.ZERO
var move_dir = Vector3.ZERO
var velocity = Vector3.ZERO
var sprint = 1
var is_up = 0
var can_fire = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	arm.rotation_degrees.x += 90
	
func _physics_process(delta):
	cam.rotation_degrees.x = look_rot.x
	rotation_degrees.y = look_rot.y

	if Input.is_action_pressed("shoot") and can_fire:
		var bullet = bull.instance()
		spawn.add_child(bullet)
		bullet.look_at(global_transform.origin, Vector3.UP)
		bullet.rotation_degrees.x += 200
		bullet.rotation_degrees.y += 20
		bullet.shoot(delta)
		can_fire = false
		yield(get_tree().create_timer(0.5), "timeout")
		can_fire = true
		bullet.queue_free()

	if Input.is_action_pressed("forward") or Input.is_action_pressed("backward") or Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		if Input.is_action_pressed("sprint"):
			anim.current_animation = "Run"
		else:
			anim.current_animation = "Move"
	else:
		anim.current_animation = "idle"
	if Input.is_action_just_pressed("jump") and is_up < max_jumps:
		is_up += 1
		velocity.y = jump
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_pressed("sprint") and is_on_floor():
		sprint = 4
	else:
		sprint = 1

	move_dir = Vector3(
		Input.get_action_strength("left") - Input.get_action_strength("right"),
		0,
		Input.get_action_strength("forward") - Input.get_action_strength("backward")
	).normalized().rotated(Vector3.UP, rotation.y)
	velocity.x = lerp(velocity.x, move_dir.x * speed * sprint, acceleration * delta)
	velocity.z = lerp(velocity.z, move_dir.z * speed * sprint, acceleration * delta)
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if translation.y < -100:
		translation = Vector3(0, 0, 0)
		
func _input(event):
	if event is InputEventMouseMotion:
		arm.rotation_degrees.x -= event.relative.y * sensitivity
		arm.rotation_degrees.x = clamp(arm.rotation_degrees.x, -60, 150)
		look_rot.y -= event.relative.x * sensitivity
		look_rot.x -= event.relative.y * sensitivity
		look_rot.x = clamp(look_rot.x,  min_angle, max_angle)

func _on_HurtBox_area_entered(area):
	stat.health -= area.damage
