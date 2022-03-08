extends "res://source/characters/Attack.gd"


var throw = load("res://source/characters/Froat/attacks/throw.gd")

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
			"start":3,
			"end":5,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[28,14,48,0]
			],
			#"unshieldable":true
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("grab")

func onHit(name, target, shielded=false):
	target.state = 5 #they are dolls and cant tech or stuff
	target.stateTimer = 0
	
	var player = get_parent()
	interrupted = true
	endAttack(player)
	player.can_walljump = false
	player.state = 1
	player.stateTimer = 0
	player.grab_target = target
	set_script(throw)
