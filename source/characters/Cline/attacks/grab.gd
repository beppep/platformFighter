extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 44
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":8,
			"end":11,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[24,18,44,10]
			],
			"extrahitpause":4,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("grab")
		player.cant_hitfall=true
		
	if player.stateTimer<10 and player._velocity.y>0:
		player._velocity.y*=0.9

func onHit(name, target, shielded=false):
	if target.getGrabbed():
		
		interrupted = true
		endAttack(false)
		
		if player.is_on_ground:
			player.attackWith("throw")
		else:
			player.attackWith("zair")
		player.cant_hitfall = true
		player.stateTimer = -1
		player.grab_target = target
