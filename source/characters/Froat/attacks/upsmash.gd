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
			"kb":150,
			"kbscaling":2,
			"angle":88,
			"shapes":[
				[80,60,0,-100]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("upsmash")
		$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".groat2)
