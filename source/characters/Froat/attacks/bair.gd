extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the script loads or somethn
func _init() -> void:
	endFrame = 33
	fastEndFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":6,
			"end":10,
			"kb":100,
			"kbscaling":1.8,
			"angle":120,
			"shapes":[
				[44,24,-70,20]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":6,
			"start":6,
			"end":10,
			"kb":100,
			"kbscaling":0.4,
			"angle":60,
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
			landingLag = 10
