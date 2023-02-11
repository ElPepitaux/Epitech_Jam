extends Spatial

onready var bat_anim = $Bat/AnimationPlayer
onready var bat = $Bat



func _process(_delta):
	bat_anim.play("CINEMA_4D_Main")
