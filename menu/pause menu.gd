extends Control

var is_paused = false setget set_is_paused

onready var settings_menu = $SettingsMenu

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused


func set_is_paused(value):
	is_paused = value 
	get_tree().paused = is_paused
	visible = is_paused


func _on_Button_pressed():
	self.is_paused = false


func _on_Button2_pressed():
	get_tree().quit()


func _on_Button3_pressed():
	settings_menu.popup_centered()
