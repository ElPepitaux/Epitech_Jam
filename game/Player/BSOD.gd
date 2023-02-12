extends Control

signal restart

onready var button_continue = $VBoxContainer/Restart
onready var button_mainmenu = $VBoxContainer/Main_Menu

func _ready():
	self.visible = false
	var min_size = Vector2.ZERO
	min_size.x = 960
	min_size.y = 130
	button_continue.rect_min_size = min_size
	button_mainmenu.rect_min_size = min_size



func _on_Restart_pressed():
	emit_signal("restart")


func _on_Main_Menu_pressed():
	get_tree().quit()
