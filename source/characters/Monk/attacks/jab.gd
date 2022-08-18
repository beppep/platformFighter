extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 15
	fastEndFrame = 10
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":3,
			"end":7,
			"kb":50,
			"kbscaling":0.2,
			"angle":50,
			"shapes":[
				[18,10,20,10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
	if not player.is_on_ground:
		interrupted = true
