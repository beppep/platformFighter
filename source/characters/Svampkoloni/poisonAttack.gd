extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 60
	fastEndFrame = 60
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":3,
			"end":6,
			"kb":80,
			"kbscaling":0.3,
			"angle":90,
			"shapes":[
				[64,64,0,-20]
			]
		},
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.play("poisonAttack")

	if player.stateTimer==12:
		player.queue_free()
