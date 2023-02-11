extends Control


onready var button_continue = $VBoxContainer/Continue
onready var button_settings = $VBoxContainer/Settings
onready var button_mainmenu = $VBoxContainer/Main_Menu

func _ready():
	var min_size = Vector2.UP
	min_size.x = 960
	min_size.y = 130
	button_continue.rect_min_size = min_size
	button_settings.rect_min_size = min_size
	button_mainmenu.rect_min_size = min_size
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible


func _on_Continue_pressed():
	self.visible = false
	get_tree().paused = false



func _on_Settings_pressed():
		get_tree().change_scene("settings")



func _on_Main_Menu_pressed():
	get_tree().change_scene("main menu")
