extends Node2D


func _ready():
	
	$AnimationPlayer.play("intro anim")
	yield(get_tree().create_timer(6), "timeout")
	$AnimationPlayer.play("out")
	yield(get_tree().create_timer(3),"timeout")
	get_tree().change_scene("res://menu.tscn")
