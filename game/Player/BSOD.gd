extends Control

onready var restart_button = $vbc/Restart
onready var menu_button = $vbc/Main_Menu
onready var restart_text = $vbc/Restart/Label
onready var menu_text = $vbc/Main_Menu/Label

func _ready():
	var min_size = Vector2.ZERO
	min_size.x = 960
	min_size.y = 540
	restart_button.rect_min_size = min_size
	menu_button.rect_min_size = min_size

func _on_Restart_pressed():
	get_tree().change_scene("res://Map.tscn")

func _on_Main_Menu_pressed():
	get_tree().change_scene("main menu")
