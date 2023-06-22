extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 34
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":8,
			"end":13,
			"kb":80,
			"kbscaling":1,
			"angle":66,
			"shapes":[
				[30,52,22,-28]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":14,
			"end":17,
			"kb":50,
			"kbscaling":0.5,
			"angle":-45,
			"shapes":[
				[30,42,22,-28]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
	if not player.is_on_ground:
		interrupted = true
