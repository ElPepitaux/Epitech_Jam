extends KinematicBody

onready var cam = $Camera
onready var spawn = $Right/RightArm/Weapon/Spawn
onready var anim = $AnimationPlayer
onready var camera = $Camera
onready var cast = $Camera/Cast
onready var end = $Camera/End
onready var arm = $Right/RightArm
onready var bull = preload("res://Player/Chouchou.tscn")
onready var hp_text = $Control/info/HP
onready var ammo_text = $Control/info/Ammo
onready var gun = $Right/RightArm/Weapon
onready var rifle = $Right/RightArm/Rifle
onready var aie = $AieScreen
onready var bsod = $BSOD
onready var current = gun
onready var cur_stat = stat_gun
onready var sound = $Sound
onready var hurtbox = $HurtBox
onready var enemy_text = $Control/info/Enemy

export var speed = 5
export var acceleration = 8
export var sensitivity = 0.2
export var max_angle = 90
export var min_angle = -80
export var gravity = 90
export var jump = 30
export var max_jumps = 2
export var max_graps = 3

var Boss = Count
var stat = PlayerStats
var look_rot = Vector3.ZERO
var arm_rot = Vector3.ZERO
var move_dir = Vector3.ZERO
var velocity = Vector3.ZERO
var sprint = 1
var is_up = 0
var can_fire = true
var hp_str = "HP : %d / 10"
var enemy_str = "Kill : %d / %d"
var ammo_str = "Ammo : %d / %d"
var graps = 0
var stat_gun = GunStats
var stat_rifle = RifleStats

func _ready():
	self.set_collision_layer_bit(2, true)
	hurtbox.set_collision_layer_bit(5, true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	stat.connect("no_health", self, "show_bsod")
	bsod.connect("restart", self, "reset")
	arm.rotation_degrees.x = 90
	rifle.visible = false
	gun.visible = true
	aie.visible = false
	stat = PlayerStats
	look_rot = Vector3.ZERO
	arm_rot = Vector3.ZERO
	move_dir = Vector3.ZERO
	velocity = Vector3.ZERO
	sprint = 1
	is_up = 0
	can_fire = true
	hp_str = "HP : %d / 10"
	enemy_str = "Kill : %d / %d"
	ammo_str = "Ammo : %d / %d"
	graps = 0
	stat_gun = GunStats
	stat_rifle = RifleStats
	Boss.enemy_died = 0
	Boss.boss = false
	
func show_bsod():
	update_text()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	bsod.visible = true
	get_tree().paused = true

func reset():
	PlayerStats.health = 10
	get_tree().change_scene("res://Map.tscn")

func _physics_process(delta):
	update_text()
	cam.rotation_degrees.x = look_rot.x
	rotation_degrees.y = look_rot.y

	if Boss.boss:
		self.set_collision_layer_bit(2, false)
		hurtbox.set_collision_layer_bit(5, false)
		anim.play("End")
	else:
		if Input.is_action_pressed("shoot") and can_fire and cur_stat.ammo > 0:
			sound.play(0.0)
			cur_stat.ammo -= 1
			var bullet = bull.instance()
			bullet.damage = cur_stat.damage
			bullet.speed = cur_stat.SPEED
			spawn.add_child(bullet)
			bullet.look_at(global_transform.origin, Vector3.UP)
			bullet.rotation_degrees.x += 200
			bullet.rotation_degrees.y += 20
			bullet.shoot(delta)
			can_fire = false
			yield(get_tree().create_timer(0.5), "timeout")
			can_fire = true
			sound.stop()
			bullet.queue_free()
			
		if Input.is_action_just_pressed("switch_weapon"):
			if gun.visible:
				use_rifle()
				current = rifle
				cur_stat = stat_rifle
			else:
				use_gun()
				current = gun
				cur_stat = stat_gun

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
		if is_on_floor():
			is_up = 0
		if not is_on_floor():
			velocity.y -= gravity * delta
		if Input.is_action_pressed("sprint"):
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
	if event is InputEventJoypadMotion:
		if event.axis == 3:
			look_rot.y -= event.axis_value * sensitivity * 50
		if event.axis == 4:
			look_rot.x -= event.axis_value * sensitivity * 50
		look_rot.x = clamp(look_rot.x,  min_angle, max_angle)
		arm.rotation_degrees.x = look_rot.x + 90
	if event is InputEventMouseMotion:
		look_rot.y -= event.relative.x * sensitivity
		look_rot.x -= event.relative.y * sensitivity
		look_rot.x = clamp(look_rot.x,  min_angle, max_angle)
		arm.rotation_degrees.x = look_rot.x + 90

func _on_HurtBox_area_entered(area):
	if not Boss.boss:
		stat.health -= area.damage
		aie.visible = true
		yield(get_tree().create_timer(0.2), "timeout")
		aie.visible = false

func update_text():
	hp_text.text = hp_str % max(0, stat.health)
	enemy_text.text = enemy_str % [Boss.enemy_died, Boss.kill_goal]
	ammo_text.text = ammo_str % [cur_stat.ammo, cur_stat.max_ammo]
	
func use_gun():
	spawn = $Right/RightArm/Weapon/Spawn
	rifle.visible = false
	gun.visible = true
	
func use_rifle():
	spawn = $Right/RightArm/Rifle/Spawn
	gun.visible = false
	rifle.visible = true

func end_animation_finished():
	Boss.boss = not Boss.boss
	print("oui") 
	get_tree().change_scene("menu")
