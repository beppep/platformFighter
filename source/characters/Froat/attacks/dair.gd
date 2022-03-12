extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":6,
			"end":11,
			"kb":80,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[24,24,10,60]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":7,
			"start":20,
			"end":26,
			"kb":120,
			"kbscaling":0.8,
			"angle":80,
			"shapes":[
				[24,24,10,60]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("dair")
	if player.is_on_floor():
		interrupted = true



func onHit(name, target, shielded=false):
	if name=="0":
		get_parent()._velocity.x*=0.5
	get_parent()._velocity.y=-950#-400*int(name)
	if name=="1" and not shielded:
		get_parent().cant_hitfall = false
		endFast = true
