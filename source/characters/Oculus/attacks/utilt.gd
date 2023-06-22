extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 32
	fastEndFrame = 23
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":3,
			"start":5,
			"end":9,
			"kb":55,
			"kbscaling":0.1,
			"angle":135,
			"shapes":[
				[20,20,20,-10]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":5,
			"start":10,
			"end":14,
			"kb":70,
			"kbscaling":1.2,
			"angle":80,
			"shapes":[
				[30,20,0,-16]
			]
		},
	]
	
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
	if not player.is_on_ground:
		interrupted = true #remove hitboxes? idk
