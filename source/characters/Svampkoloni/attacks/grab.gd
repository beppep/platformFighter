extends "res://source/characters/Attack.gd"


var throw = load("res://source/characters/Godtest/attacks/throw.gd")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	endFrame = 37
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":11,
			"end":14,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[52,20,94,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("grab")
		player._velocity = Vector2.ZERO

func onHit(name, target, shielded=false):
	target.getGrabbed()
	
	interrupted = true
	endAttack()
	
	player.attackWith("throw")
	player.stateTimer = -1
	player.grab_target = target
