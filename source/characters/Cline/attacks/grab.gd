extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 40
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":6,
			"end":10,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[32,20,44,10]
			],
			#"unshieldable":true
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("grab")
		
		player.cant_hitfall=true

func onHit(name, target, shielded=false):
	target.getGrabbed()
	
	interrupted = true
	endAttack()
	
	if player.is_on_ground:
		player.attackWith("throw")
	else:
		player.attackWith("zair")
	player.cant_hitfall = true
	player.stateTimer = -1
	player.grab_target = target
