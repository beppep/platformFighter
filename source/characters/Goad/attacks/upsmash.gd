extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
var chargeTime



# Called when the script loads or somethn #nooooooot lmao
func _init() -> void:
	
	endFrame = 64
	fastEndFrame = 46
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":19,
			"end":25,
			"kb":110,
			"kbscaling":3,
			"angle":88,
			"shapes":[
				[70,57,0,-100]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	player._velocity.y *= 0.8
	if player.stateTimer==0:
		player.anim_sprite.play("upsmash")
		player.get_node("/root/Node2D/AudioStreamPlayer").playSound(player.get_node("/root/Node2D/AudioStreamPlayer").groat2)
