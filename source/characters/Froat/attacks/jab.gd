extends "res://source/characters/Attack.gd"


var jab2 = load("res://source/characters/Froat/attacks/jab2.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 16
	fastEndFrame = 10
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":3,
			"end":5,
			"kb":40,
			"kbscaling":0.2,
			"angle":60,
			"shapes":[
				[28,14,48,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
	if not player.is_on_ground:
		interrupted = true
	if player.stateTimer == 9 and player.buttons[1]:
		interrupted = true
		endAttack(player)
		
		player.attackWith(jab2)
		player.stateTimer = -1
