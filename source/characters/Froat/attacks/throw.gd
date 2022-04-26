extends "res://source/characters/Attack.gd"

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target

# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 14
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":8,
			"end":9,
			"kb":120,
			"kbscaling":1,
			"angle":80,
			"autolink":1,
			"shapes":[
				[28,28,48,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.cant_hitfall = true
	if player.stateTimer==1:
		player._velocity*=0.5
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("throw")
	if player.stateTimer<7:
		player.grab_target.position = player.position+Vector2(50,0)*player.transform.x.x
		player.grab_target._velocity = player._velocity

func onHit(name, target, shielded=false):
	pass
