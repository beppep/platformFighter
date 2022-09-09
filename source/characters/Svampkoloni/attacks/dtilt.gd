extends "res://source/characters/Attack.gd"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 25
	fastEndFrame = 17
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":6,
			"end":9,
			"kb":79,
			"kbscaling":0.7,
			"angle":91,
			"shapes":[
				[16,16,88,26]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
	if player.stateTimer==4:
		var newSvamp = player.svampScene.instance()
		newSvamp.position = player.position + Vector2(player.transform.x.x*90,40)
		player.get_node("/root/Node2D/fx").add_child(newSvamp)
		newSvamp.get_node("Sprite").modulate = player.sprite_color
	if not player.is_on_ground:
		pass
		#interrupted = true
