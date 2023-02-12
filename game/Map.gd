extends Spatial

onready var bat_anim = $scene/AnimationPlayer
onready var bat = $scence

func _process(_delta):
	bat_anim.play("CINEMA_4D_Main")
