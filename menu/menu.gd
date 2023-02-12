extends Node2D


export var gameScene : PackedScene

onready var settings_menu = $SettingsMenu

func _on_TextureButton_button_up():
	get_tree().change_scene(gameScene.resource_path)


func _on_TextureButton2_pressed():
	get_tree().quit()


func _on_TextureButton3_pressed():
	settings_menu.popup_centered()
