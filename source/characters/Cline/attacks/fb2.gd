extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 34
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":9,
			"end":20,
			"kb":30,
			"kbscaling":0.5,
			"angle":45,
			"shapes":[
				[32,12,34,20]
			],
		}
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer == 0:
		player.anim_sprite.play("fb")

	if player.stateTimer==10:
		
		var ghast = player.ghostScene.instantiate()
		ghast.position = player.position + Vector2(10,0)*player.transform.x.x
		ghast.team = player.team
		ghast.transform.x.x = player.transform.x.x
		ghast._velocity = Vector2(600*player.transform.x.x,0)
		player.get_node("/root/Node2D/Articles").add_child(ghast)
		ghast.attackWith("ghostAttack")
		ghast.anim_sprite.play("down")
