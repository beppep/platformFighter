extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 26
	fastEndFrame = 16
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":6,
			"end":10,
			"kb":100,
			"kbscaling":1.3,
			"angle":50,
			"shapes":[
				[45,25,55,-6]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("ftilt")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10
