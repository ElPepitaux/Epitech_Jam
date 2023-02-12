extends Node

signal fps_displayed(value)
signal bloom_toggled(value)
signal brightness_update(value)
signal fov_updated(value)
signal mouse_sens_updated(value)

func toggle_fullscreen(value):
	OS.window_fullscreen = value
	
	
func toggle_vsync(value):
	OS.vsync_enabled = value


func toggle_fps_display(value):
	emit_signal("fps_displayed", value)


func set_max_fps(value):
	Engine.target_fps = value if value < 500 else 0
	
	
func toggle_bloom(value) :
	emit_signal("bloom_toggled", value)
	
	
func update_brightness(value):
	emit_signal("brightness_update", value)
	
	
func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	

func update_fov(value):
	emit_signal("fov_updated", value)


func update_mouse_sens(value):
	emit_signal("mouse_sens_updated", value)
