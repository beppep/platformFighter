extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 42
	fastEndFrame = 32
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":11,
			"end":14,
			"kb":70,
			"kbscaling":1.2,
			"angle":150,
			"shapes":[
				[34,44,-60,10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 11
