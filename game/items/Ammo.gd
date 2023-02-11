extends Spatial

var rifle = RifleStats
var gun = GunStats

func _on_HurtBox_body_entered(body):
	if body.get_name() == "Player":
		if gun.ammo < 18:
			gun.ammo += 7
		if rifle.ammo < 3:
			rifle.ammo += 2
		queue_free()
