extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 44
	fastEndFrame = 32
	hitboxes = [
		{
			"name":"0", # idk man. kinda meh
			"group":0,
			"damage":3,
			"start":6,
			"end":7,
			"kb":40,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[25,25,25,-35]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":2,
			"start":12,
			"end":13,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[25,25,25,-55]
			]
		},
		{
			"name":"2",
			"group":2,
			"damage":2,
			"start":14,
			"end":15,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[25,25,25,-55]
			]
		},
		{
			"name":"3",
			"group":3,
			"damage":4,
			"start":16,
			"end":18,
			"kb":70,
			"kbscaling":1.1,
			"angle":81,
			"shapes":[
				[25,25,25,-55]
			]
		},
	]
	
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
	if not player.is_on_ground:
		interrupted = true #remove hitboxes? idk
