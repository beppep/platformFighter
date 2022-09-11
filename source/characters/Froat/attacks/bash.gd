extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the script loads or somethn
func _init():
	endFrame = 34
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":9,
			"end":12,
			"kb":57,
			"kbscaling":1.5,
			"angle":-80,
			"shapes":[
				[20,20,60,10]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":7,
			"start":9,
			"end":20,
			"kb":45,
			"kbscaling":0.5,
			"angle":100,
			"shapes":[
				[40,40,-5,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_sprite.play("nair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 11

func onHit(name, target, shielded=false):
	#player._velocity.y*=0.7
	player._velocity.y=-999
	if not shielded:
		endFast = true
