extends RigidBody

export var damage = 50
export var speed = 100

func _ready():
	set_as_toplevel(true)
	
func shoot(delta):
	apply_impulse(transform.basis.z, -transform.basis.z * speed)
