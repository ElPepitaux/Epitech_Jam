extends KinematicBody

var gravity = -9.8
var velocity = Vector3()

const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	# camera = get_node("../Camera").get_global_transform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var dir = Vector3()
	
	dir += Vector3(1, 0, 0)
	
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y = delta * gravity
	
	var hv = velocity
	
	hv.y = 0
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
