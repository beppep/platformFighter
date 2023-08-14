extends "res://source/characters/Attack.gd"


var throw = load("res://source/characters/Godtest/attacks/throw.gd")


# den är lite grotesk. kanske ska vara lite kortare.

func _init():
	endFrame = 47
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
				[32,30,105,-25]
			],
			"extrahitpause":4,
		},
		{
			"name":"1",
			"group":1,
			"damage":1,
			"start":10,
			"end":14,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[32,20,75,-5]
			],
			"extrahitpause":4,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("zair")
	if player.stateTimer<37:
		player._velocity *= 0.9
		#player._velocity.y -= 50

func onHit(name, target, shielded=false):
	if target.getGrabbed() and player.state != 2:
		
		interrupted = true
		endAttack(false)
		
		player.attackWith("throw2")
		player.stateTimer = -1
		player.grab_target = target
