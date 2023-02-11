extends RigidBody

export var damage = 50
export var speed = 350

onready var hitbox = $Hitbox/CollisionShape

func _ready():
	set_as_toplevel(true)
	
func shoot(delta):
	apply_impulse(transform.basis.z, -transform.basis.z * speed)


func _on_Hitbox_area_entered(area):
	hitbox.disabled = true
