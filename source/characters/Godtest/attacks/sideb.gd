extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 58
	fastEndFrame = 46
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":17,
			"end":21,
			"kb":70,
			"kbscaling":3.1,
			"angle":40,
			"shapes":[
				[36,30,50,-8]
			]
		},
	]

func update():
	if player.stateTimer<30:
		player._velocity *= 0.2
	if player.stateTimer==0:
		player.anim_sprite.play("sideb")

func onHit(name, target, shielded=false):
	if not shielded:
		player._velocity.y=0
