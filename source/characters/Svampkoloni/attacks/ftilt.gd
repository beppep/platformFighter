extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 29
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":4,
			"end":6,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[30,16,48,-8]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":8,
			"end":11,
			"kb":100,
			"kbscaling":1,
			"angle":125,
			"shapes":[
				[34,20,48,-8]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("ftilt")
	if player.stateTimer==7:
		player.cant_hitfall = false

func onHit(name, target, shielded=false):
	
	if name=="0":
		get_parent()._velocity.x*=0.5
		get_parent()._velocity.y*=0.5
		get_parent()._velocity.y-=300
	if name=="1":
		pass
		#get_parent()._velocity.y-=400
	if name=="1" and not shielded:
		endFast = true
