extends "res://source/characters/Attack.gd"

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target

# Called when the node enters the scene tree for the first time.
func _init():
	endFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":16,
			"end":18,
			"kb":100,
			"kbscaling":2.5,
			"angle":110,
			"shapes":[
				[30,30,92,-78]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==1:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("throw")
	if player.stateTimer<10:
		player.grab_target.position = player.position+Vector2(50*player.transform.x.x,0)
		player.grab_target._velocity = player._velocity
	if player.stateTimer==10:
		player.grab_target._velocity = player._velocity+Vector2(660*player.transform.x.x,-1460)

func onHit(name, target, shielded=false):
	pass
