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
			"angle":130,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[30,30,90,-99]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==1:
		player.anim_sprite.play("throw")
		player.cant_hitfall=true
	if player.stateTimer<10:
		player.grab_target.position = player.position+Vector2(50*player.transform.x.x,0)
		player.grab_target._velocity = player._velocity
	if player.stateTimer==10:
		player.grab_target._velocity = player._velocity*0.5+Vector2(600*player.transform.x.x,-1000)

func onHit(name, target, shielded=false):
	pass
