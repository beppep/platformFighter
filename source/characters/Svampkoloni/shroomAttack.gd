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
			"damage":4,
			"start":3,
			"end":6,
			"kb":40,
			"kbscaling":0.3,
			"angle":90,
			"shapes":[
				[64,64,0,-20]
			]
		},
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.play("attack")

	if player.stateTimer==8:
		randomize()
		for i in 15:
			var svamp = player.myOwner.moldSpore.instance()
			svamp.position = player.position
			svamp.team = player.team
			svamp.transform.x.x = player.transform.x.x
			svamp._velocity = Vector2(rand_range(-100, 100),rand_range(0,-200))
			player.get_node("/root/Node2D/Articles").add_child(svamp)
			svamp.attackWith("moldSporeAttack")
			svamp.modulate = player.myOwner.sprite_color
			svamp.anim_sprite.play("spore") 
			svamp.myOwner = player.myOwner
		player.myOwner.shroomList.erase(player)
		player.queue_free()
