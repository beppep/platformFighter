extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":10,
			"end":12,
			"kb":40,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":1,
			"shapes":[
				[30,16,98,-8]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":20,
			"end":23,
			"kb":100,
			"kbscaling":0.5,
			"angle":145,
			"shapes":[
				[36,20,98,-8]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.amin_sprite.play("fspec")
