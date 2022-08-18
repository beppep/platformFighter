extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 36
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":20,
			"start":18,
			"end":26,
			"kb":120,
			"kbscaling":3,
			"angle":250,
			"shapes":[
				[10,15,-68,30]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":14,
			"start":11,
			"end":18,
			"kb":80,
			"kbscaling":1.5,
			"angle":180-30,
			"shapes":[
				[20,40,-68,-10]
			]
		},
		{
			"name":"2",
			"group":1,
			"damage":14,
			"start":18,
			"end":26,
			"kb":80,
			"kbscaling":1.5,
			"angle":180-30,
			"shapes":[
				[20,25,-68,-17]
			]
		},
		
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 5
