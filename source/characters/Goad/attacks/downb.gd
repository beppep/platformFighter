extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 40 #?
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":10,
			"start":15,
			"end":30,
			"kb":60,
			"kbscaling":1.6,
			"angle":-90,
			"shapes":[
				[40,25,0,25]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("downb")
	if player.stateTimer<12:
		player._velocity *= 0.8#Vector2(0, -60)
	if 16<player.stateTimer and player.stateTimer<30:
		if not interrupted: #why
			player._velocity.y = 2000
		#player.double_jumps = 1 #?
	if player.stateTimer>30:
		player.double_jumps = 1
		player._velocity *= 0
	#if player.is_on_floor() and player.stateTimer==fastEndFrame and player.buttons[0]:
		#player._velocity = Vector2(0, -3000)
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 25

func onHit(name, target, shielded=false):
	player._velocity.y=-1000
	
	if not shielded:
		#endFast = true
		interrupted = true
		
