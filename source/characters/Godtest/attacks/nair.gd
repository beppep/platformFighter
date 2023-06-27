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
			"damage":8,
			"start":5,
			"end":7,
			"kb":60,
			"kbscaling":1.2,
			"angle":60,
			"shapes":[
				[44,33,0,-44]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":8,
			"start":7,
			"end":11,
			"kb":60,
			"kbscaling":1.2,
			"angle":70,
			"shapes":[
				[33,44,44,0]
			]
		},
		{
			"name":"2",
			"group":1,
			"damage":8,
			"start":11,
			"end":14,
			"kb":60,
			"kbscaling":1.2,
			"angle":60,
			"shapes":[
				[44,33,0,44]
			]
		},
		{
			"name":"3",
			"group":1,
			"damage":10,
			"start":16,
			"end":19,
			"kb":70,
			"kbscaling":1.5,
			"angle":60,
			"shapes":[
				[20,30,-40,-5]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10
