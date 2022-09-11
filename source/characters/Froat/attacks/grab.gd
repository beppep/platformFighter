extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 36
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":5,
			"end":8,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[28,14,48,0]
			],
			#"unshieldable":true
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("grab")
		

func onHit(name, target, shielded=false):
	target.state = 5 #they are dolls and cant tech or stuff
	target.stateTimer = 0
	
	interrupted = true
	endAttack()
	
	player.attackWith("throw")
	player.cant_hitfall = true
	player.stateTimer = -1
	player.grab_target = target
