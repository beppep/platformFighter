extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 31
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"earth",
			"group":1,
			"damage":10,
			"start":12,
			"end":15,
			"kb":45,
			"kbscaling":0.3,
			"angle":50,
			"autolink":1,
			"shapes":[
				[25,25,22,6]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":18,
			"end":27,
			"kb":110,
			"kbscaling":1,
			"angle":100,
			"shapes":[
				[15,30,-8,-87]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("utilt")
	if not player.is_on_floor():
		interrupted = true
