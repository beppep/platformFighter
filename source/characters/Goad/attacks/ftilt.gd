extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 36
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":6,
			"end":11,
			"kb":90,
			"kbscaling":0.8,
			"angle":45,
			"shapes":[
				[36,30,16,-15]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
	if 5<player.stateTimer and player.stateTimer<10:
		player._velocity.x = player.transform.x.x*666
	#if not player.is_on_ground:
		#interrupted = true
