extends "res://source/characters/Attack.gd"


var throw = load("res://source/characters/Godtest/attacks/throw.gd")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 37
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":4,
			"end":6,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[32,20,44,5]
			],
			#"unshieldable":true
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("grab")
		
		player.cant_hitfall=true

func onHit(name, target, shielded=false):
	target.state = 5
	target.stateTimer = 0
	
	var player = get_parent()
	interrupted = true
	endAttack(player)
	
	player.attackWith(throw)
	player.stateTimer = -1
	player.grab_target = target
