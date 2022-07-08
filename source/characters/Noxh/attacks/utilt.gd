extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 30
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":8,
			"start":7,
			"end":10,
			"kb":90,
			"kbscaling":0.5,
			"angle":100,
			"shapes":[
				[30,40,30,-40]
			]
		},
		{
			"name":"1",
			"group":0,
			"damage":8,
			"start":10,
			"end":13,
			"kb":80,
			"kbscaling":0.5,
			"angle":110,
			"shapes":[
				[30,40,-30,-40]
			]
		},
	]

func onEnd():
	player.transform.x.x *= -1 #would be nicer if it flipped at the start? no glitch frame
	
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if not player.is_on_ground:
		interrupted = true #remove hitboxes? idk
