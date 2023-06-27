extends "res://source/characters/Attack.gd"

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target

# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":15,
			"end":18,
			"kb":120,
			"kbscaling":0.5,
			"angle":50,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[30,30,-40,-33]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("throw")
	if player.stateTimer<10:
		player.grab_target.position = player.position+Vector2(50,0)*cos(player.stateTimer*0.2)*player.transform.x.x+Vector2(0,-50)*sin(player.stateTimer*0.2)
		player.grab_target._velocity = player._velocity
	elif player.stateTimer<16:
		player.grab_target.position = player.position+Vector2(50,0)*cos(2)*player.transform.x.x+Vector2(0,-50)*sin(2)
		player.grab_target._velocity = player._velocity*0.5+Vector2(600*player.transform.x.x,-1000)

func onHit(name, target, shielded=false):
	pass
