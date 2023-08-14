extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 37
	fastEndFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":10,
			"end":15,
			"kb":70,
			"kbscaling":0.6,
			"angle":66,
			"shapes":[
				[30,30,40,25]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fair")
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 9
