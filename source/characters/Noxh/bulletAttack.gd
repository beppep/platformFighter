extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the script loads or somethn
func _init() -> void:
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"kb":80,
			"kbscaling":0.5,
			"angle":-60#80,
		},
	]


func update(player):
	pass #nevercalled?

