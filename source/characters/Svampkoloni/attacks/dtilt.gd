extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var svamp = load("res://source/Characters/Svampkoloni/svamp.tscn")

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 25
	fastEndFrame = 17
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":5,
			"end":9,
			"kb":100,
			"kbscaling":1,
			"angle":77,
			"shapes":[
				[16,16,68,26]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("dtilt")
	if player.stateTimer==4:
		var newSvamp = svamp.instance()
		newSvamp.position = player.position + Vector2(player.transform.x.x*70,24)
		get_node("/root/Node2D/fx").add_child(newSvamp)
		newSvamp.get_node("Sprite").modulate = player.sprite_color
	if not player.is_on_ground:
		interrupted = true
