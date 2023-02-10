extends RigidBody

export var damage = 50
export var speed = 100

func _ready():
	set_as_toplevel(true)
	
func shoot(delta):
	apply_impulse(transform.basis.z, -transform.basis.z * speed)

func _on_Chouchou_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("enemy"):
		body.health -= damage
	queue_free()
