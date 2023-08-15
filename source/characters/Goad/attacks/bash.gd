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
			"start":8,
			"end":12,
			"kb":50,
			"kbscaling":0.9,
			"angle":-50,
			"shapes":[
				[40,40,60,10]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":7,
			"start":8,
			"end":20,
			"kb":55,
			"kbscaling":0.7,
			"angle":111,
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
	if name == "0":
		pass
		player._velocity.y=-900
	if not shielded:
		endFast = true
