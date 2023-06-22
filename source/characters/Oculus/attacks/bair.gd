extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 35
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":6,
			"end":14,
			"kb":50,
			"kbscaling":0.5,
			"angle":120,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,-30,10]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
		#player.cant_hitfall=true
		
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 15

func onHit(name, target, shielded=false):
	if target.getGrabbed():
		
		target.state = 2
		interrupted = true
		endAttack(false)
		
		player.attackWith("bair2")
		#player.cant_hitfall = true
		player.stateTimer = -1
		player.grab_target = target

