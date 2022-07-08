extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 18
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":6,
			"end":9,
			"kb":50,
			"kbscaling":1.1,
			"angle":45,
			"shapes":[
				[50,20,55,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
	if not player.is_on_ground:
		pass
		#interrupted = true
