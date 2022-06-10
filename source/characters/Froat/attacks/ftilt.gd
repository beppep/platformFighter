extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 31
	fastEndFrame = 17
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":6,
			"end":10,
			"kb":70,
			"kbscaling":1.5,
			"angle":33,
			"shapes":[
				[43,25,53,-16]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
	if not player.is_on_ground:
		interrupted = true
