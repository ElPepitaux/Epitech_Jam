extends Label

func _ready():
	GlobalSettings.connect("fps_displayed", self, "on_fps_displayed")
	
	
func _process(delta):
	text = "FPS: %s" %  str([Engine.get_frames_per_second()])
	
	
func on_fps_displayed(value):
	visible = value
