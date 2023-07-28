extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":7,
			"end":10,
			"kb":90,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":1,
			"shapes":[
				[24,27,3,80]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":15,
			"end":20,
			"kb":80,
			"kbscaling":1.1,
			"angle":60,
			"shapes":[
				[24,24,3,80]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("dair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10



func onHit(name, target, shielded=false):
	if name=="0":
		player._velocity.x*=0.8
	player._velocity.y=-750#+100*int(name)
	if name=="1" and not shielded:
		player.cant_hitfall = false
	endFast = true
