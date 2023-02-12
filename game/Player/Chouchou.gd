extends RigidBody

export var damage = 50
export var speed = 200

onready var hitbox = $Hitbox/CollisionShape
onready var hit = $Hitbox
onready var explosion = $Explosion
onready var animation = $Explosion/AnimationPlayer

func _ready():
	set_as_toplevel(true)
	explosion.visible = false
	
	
func shoot(delta):
	hit.damage = damage
	apply_impulse(transform.basis.z, -transform.basis.z * speed)


func _on_Hitbox_area_entered(area):
	hitbox.set_deferred("disable", true)
	explosion.visible = true
	animation.play("Icosphere001Action")
	self.sleeping = true
	
