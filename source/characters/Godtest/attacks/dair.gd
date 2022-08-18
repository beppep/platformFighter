extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 23
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":7,
			"end":10,
			"kb":50,
			"kbscaling":1,
			"angle":-90,
			"shapes":[
				[18,28,4,70]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10


func onHit(name, target, shielded=false):
	player._velocity.y=-1000
	if not shielded:
		endFast = true
