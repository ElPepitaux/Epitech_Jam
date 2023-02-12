extends WorldEnvironment

func _ready():
	GlobalSettings.connect("bloom_toggled", self, "_on_bloom_toggled")
	GlobalSettings.connect("brightness_update", self, "_on_brightness_updated")
	
	
func _on_bloom_toggled(value):
	environment.glow_enabled = value
	
	
func _on_brightness_updated(value):
	environment.adjustment_brightness = value 
