extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the script loads or somethn
func _init() -> void:
	endFrame = 39
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":7,
			"end":9,
			"kb":50,
			"kbscaling":1.8,
			"angle":140,
			"shapes":[
				[14,24,-100,20]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":6,
			"start":7,
			"end":13,
			"kb":30,
			"kbscaling":0.8,
			"angle":140,
			"shapes":[
				[44,24,-70,20]
			]
		},
		{
			"name":"2",
			"group":1,
			"damage":4,
			"start":6,
			"end":10,
			"kb":23,
			"kbscaling":0.35,
			"angle":12,
			"shapes":[
				[24,24,30,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 15
