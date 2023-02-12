extends Spatial

var rifle = RifleStats
var gun = GunStats

func _on_HurtBox_body_entered(body):
	if body.get_name() == "Player":
		gun.ammo += 7
		if gun.ammo > 20:
			gun.ammo = 20
		rifle.ammo += 2
		if rifle.ammo > 5:
			rifle.ammo = 5
		queue_free()
