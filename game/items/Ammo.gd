extends Spatial

var rifle = RifleStats
var gun = GunStats

func _on_HurtBox_body_entered(body):
	if body.get_name() == "Player":
		if gun.ammo < 24:
			gun.ammo += 2
		if rifle.ammo < 4:
			rifle.ammo += 1
		queue_free()
