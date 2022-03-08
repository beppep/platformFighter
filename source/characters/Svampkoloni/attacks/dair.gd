extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":7,
			"end":9,
			"kb":50,
			"kbscaling":0.1,
			"angle":-90,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":11,
			"end":13,
			"kb":50,
			"kbscaling":0.1,
			"angle":-90,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":3,
			"start":15,
			"end":17,
			"kb":50,
			"kbscaling":0.1,
			"angle":-90,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":3,
			"start":19,
			"end":21,
			"kb":50,
			"kbscaling":1,
			"angle":-90,
			"shapes":[
				[28,28,0,40]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("dair")
	if player.is_on_floor():
		interrupted = true


func onHit(name, target, shielded=false):
	if name!="3":
		get_parent()._velocity.y*=0.5
	if name=="3" and not shielded:
		get_parent().cant_hitfall = false
		endFast = true
