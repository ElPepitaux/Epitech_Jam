extends Control


onready var button_continue = $VBoxContainer/Continue
onready var button_settings = $VBoxContainer/Settings
onready var button_mainmenu = $VBoxContainer/Main_Menu
onready var settings_menu = $SettingsMenu

var player = PlayerStats

func _ready():
	self.visible = false
	var min_size = Vector2.UP
	min_size.x = 960
	min_size.y = 130	
	button_continue.rect_min_size = min_size
	button_settings.rect_min_size = min_size
	button_mainmenu.rect_min_size = min_size
	
func _process(delta):
	if Input.is_action_just_pressed("pause") and player.health > 0:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = not get_tree().paused
		self.visible = not self.visible

func _on_Continue_pressed():
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _on_Settings_pressed():
	settings_menu.popup_centered()	

func _on_Main_Menu_pressed():
	get_tree().root.queue_free()
