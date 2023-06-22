extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":4,
			"end":7,
			"kb":20,
			"kbscaling":0.1,
			"angle":40,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[24,18,66,-10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":12,
			"end":15,
			"kb":100,
			"kbscaling":1,
			"angle":45,
			"shapes":[
				[24,18,66,-10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("ftilt")
	if player.stateTimer==7:
		player.cant_hitfall = false

func onHit(name, target, shielded=false):
	
	if name=="0":
		player._velocity.x*=0.5
		player._velocity.y*=0.5
		player._velocity.y-=300
	if not shielded:
		endFast = true
