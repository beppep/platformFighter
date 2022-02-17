extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":7,
			"end":10,
			"kb":80,
			"kbscaling":1,
			"angle":-90,
			"shapes":[
				[18,28,4,70]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("dair")
	if player.is_on_floor():
		interrupted = true


func onHit(name, target, shielded=false):
	get_parent()._velocity.y=-100
	if not shielded:
		endFrame = fastEndFrame
