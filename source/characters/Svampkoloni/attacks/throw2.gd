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
			"start":12,
			"end":14,
			"kb":80,
			"kbscaling":0.4,
			"angle":108,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[32,30,104,-45]
			]
		},
	]

func update():
	if player.stateTimer==0:
		pass
		player.anim_sprite.play("throw2")
	if player.stateTimer>12:
		player._velocity.y *= 0.9
		player._velocity.y -= 50
	if player.stateTimer<12:
		player.grab_target.position = player.position+Vector2(100*player.transform.x.x,-50)
		player.grab_target._velocity = player._velocity
		

func onHit(name, target, shielded=false):
	pass
