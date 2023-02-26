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
			"damage":10,
			"start":8,
			"end":9,
			"kb":60,
			"kbscaling":1.5,
			"angle":120,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[28,28,-48,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
	if player.stateTimer==1:
		player._velocity*=0.5 #WHY?
		player.anim_sprite.play("uair")
	if player.stateTimer<7:
		player.grab_target.position = player.position+Vector2(50,0)*cos(player.stateTimer*0.5)*player.transform.x.x+Vector2(0,-50)*sin(player.stateTimer*0.5)
		player.grab_target._velocity = player._velocity
