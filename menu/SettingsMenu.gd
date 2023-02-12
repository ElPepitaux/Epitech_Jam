extends Popup

# video settings
onready var display_options = $settings/video/MarginContainer/VideoSettings/DisplayMode
onready var  vsync_button = $settings/video/MarginContainer/VideoSettings/CheckButton
onready var display_button = $settings/video/MarginContainer/VideoSettings/CheckButton2
onready var max_fps_val = $settings/video/MarginContainer/VideoSettings/HBoxContainer/Label
onready var max_fps_slider = $settings/video/MarginContainer/VideoSettings/HBoxContainer/HSlider
onready var bloom_btn = $settings/video/MarginContainer/VideoSettings/CheckButton3
onready var brightness_slider = $settings/video/MarginContainer/VideoSettings/HSlider

# Audio Settings
onready var master_vol_slider = $settings/Audio/MarginContainer/AudioSettings/mastervol
onready var music_vol_slider = $settings/Audio/MarginContainer/AudioSettings/musicvol2
onready var sfx_vol_slider = $settings/Audio/MarginContainer/AudioSettings/sfx2

# Gameplay settings
onready var fov_val = $settings/Gameplay/MarginContainer/GameSettings/HBoxContainer/FovVal
onready var fov_slider = $settings/Gameplay/MarginContainer/GameSettings/HBoxContainer/fov2
onready var mouse_sens_val = $settings/Gameplay/MarginContainer/GameSettings/HBoxContainer2/MouseSens
onready var mouse_sen_slider = $settings/Gameplay/MarginContainer/GameSettings/HBoxContainer2/MouseSens2

func _ready():
	pass


func _on_DM_item_selected(index):
	GlobalSettings.toggle_fullscreen(true if index == 1 else false)


func _on_CheckButton_toggled(button_pressed):
	 GlobalSettings.toggle_vsync(button_pressed)


func _on_CheckButton2_toggled(button_pressed):
	GlobalSettings.toggle_fps_display(button_pressed)


func _on_HSlider_value_changed(value):
	GlobalSettings.set_max_fps(value)
	max_fps_val.text = str(value) if value < max_fps_slider.max_value else "max"



func _on_CheckButton3_toggled(button_pressed):
	GlobalSettings.toggle_bloom(button_pressed)


func _on_BrightnessSlider_value_changed(value):
	GlobalSettings.update_brightness(value)


func _on_mastervol_value_changed(value):
	GlobalSettings.update_master_vol(value)


func _on_musicvol2_value_changed(value):
	pass


func _on_sfx2_value_changed(value):
	pass
	


func _on_fov2_value_changed(value):
	GlobalSettings.update_fov(value)
	fov_val.text = str(value)

func _on_MouseSens2_value_changed(value):
	GlobalSettings.update_mouse_sens(value)
	mouse_sens_val.text = str(value)
