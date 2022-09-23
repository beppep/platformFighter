extends "res://source/characters/Attack.gd"


var throw = load("res://source/characters/Godtest/attacks/throw.gd")


# den är lite grotesk. kanske ska vara lite kortare.

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
				[32,30,104,-45]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("zair")
	if player.stateTimer<30:
		player._velocity *= 0.9
		#player._velocity.y -= 50

func onHit(name, target, shielded=false):
	target.state = 5
	target.stateTimer = 0
	
	interrupted = true
	endAttack()
	
	player.attackWith("throw2")
	player.stateTimer = -1
	player.grab_target = target
