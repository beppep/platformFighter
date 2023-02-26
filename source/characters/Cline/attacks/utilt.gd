extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 30
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":8,
			"start":8,
			"end":11,
			"kb":65,
			"kbscaling":1.5,
			"angle":80,
			"shapes":[
				[35,35,-45,-35]
			]
		},
		{
			"name":"1",
			"group":0,
			"damage":8,
			"start":10,
			"end":13,
			"kb":64,
			"kbscaling":1.5,
			"angle":90,
			"shapes":[
				[35,35,30,-30]
			]
		},
	]
	
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
	if not player.is_on_ground:
		interrupted = true #remove hitboxes? idk
