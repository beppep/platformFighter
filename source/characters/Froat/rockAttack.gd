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
			"damage":9,
			"kb":80,
			"kbscaling":1,
			"angle":60,
		},
	]


func update(player):
	hitboxes[0]["angle"] = rad2deg(-player._velocity.angle())

func onHit(name, target, shielded=false):
	if shielded:
		get_parent()._velocity *= -1
		
		#get_parent()._velocity.y -= 500
		#get_parent().team = -1
