extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 18
	fastEndFrame = 9
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":4,
			"end":6,
			"kb":50,
			"kbscaling":0.3,
			"angle":60,
			"shapes":[
				[28,15,48,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
		player.anim_sprite.set_frame(0)
	if not player.is_on_ground:
		interrupted = true
