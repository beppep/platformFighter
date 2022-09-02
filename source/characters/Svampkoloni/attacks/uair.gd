extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 26
	fastEndFrame = 18
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":3,
			"start":5,
			"end":8,
			"kb":20,
			"kbscaling":0.1,
			"angle":85,
			"shapes":[
				[20,40,20,-60]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":8,
			"start":10,
			"end":12,
			"kb":50,
			"kbscaling":1,
			"angle":-60,
			"shapes":[
				[24,44,20,-60]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("uair")
	if player.stateTimer==9:
		player.cant_hitfall = false
	#if player.is_on_floor():
	#	interrupted = true



func onHit(name, target, shielded=false):
	if name=="0":
		get_parent()._velocity.y=-100
	if name=="1":
		pass
		get_parent()._velocity.y=-1400
	if name=="1" and not shielded:
		endFast = true
