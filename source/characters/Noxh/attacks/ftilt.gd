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
			"damage":9,
			"start":6,
			"end":8,
			"kb":50,
			"kbscaling":1.1,
			"angle":40,
			"shapes":[
				[10,10,95,5]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":6,
			"start":6,
			"end":9,
			"kb":33,
			"kbscaling":0.8,
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
