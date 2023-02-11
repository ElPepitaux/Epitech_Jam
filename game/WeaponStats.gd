extends Node

export (int) var max_ammo = 1
onready var ammo = max_ammo setget shotting
export (int) var SPEED = 1

signal no_ammo

func shotting(value):
	ammo = value
	if ammo <= 0:
		emit_signal("no_ammo")
