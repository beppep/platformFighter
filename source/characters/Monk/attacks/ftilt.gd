extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"earth",
			"group":1,
			"damage":12,
			"start":14,
			"end":16,
			"kb":60,
			"kbscaling":0.8,
			"angle":180-80,
			"shapes":[
				[20,20,-52,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":8,
			"start":19,
			"end":25,
			"kb":70,
			"kbscaling":0.8,
			"angle":25,
			"shapes":[
				[30,18,55,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("ftilt")
	if player.stateTimer==7:
		player.cant_hitfall = false

#func onHit(name, target, shielded=false):
#	
#	if name=="0":
#		get_parent()._velocity.x*=0.5
#		get_parent()._velocity.y*=0.5
#		get_parent()._velocity.y-=300
#	if name=="1":
#		pass
#		#get_parent()._velocity.y-=400
#	if name=="1" and not shielded:
#		endFast = true
