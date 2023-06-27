extends "res://source/characters/Attack.gd"


var throw = load("res://source/characters/Godtest/attacks/throw.gd")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 45
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":10,
			"end":13,
			"kb":0,
			"kbscaling":0,
			"angle":90,
			"shapes":[
				[26,16,60,-10]
			],
			"extrahitpause":4,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("grab")
		
		player.cant_hitfall=true

func onHit(name, target, shielded=false):
	if target.getGrabbed():
		
		interrupted = true
		endAttack(false)
		
		player.attackWith("throw")
		player.cant_hitfall = true
		player.stateTimer = -1
		player.grab_target = target
