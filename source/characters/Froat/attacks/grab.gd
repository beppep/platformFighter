extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 46
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":7,
			"end":12,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[22,20,48,0]
			],
			"extrahitpause":4,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("grab")
		player.cant_hitfall = true

func onHit(name, target, shielded=false):
	if target.getGrabbed() and player.state != 2:
		
		interrupted = true
		endAttack(false)
		
		player.attackWith("throw")
		player.cant_hitfall = true
		player.stateTimer = -1
		player.grab_target = target
