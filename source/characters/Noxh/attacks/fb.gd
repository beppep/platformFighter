extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":11,
			"end":14,
			"kb":70,
			"kbscaling":0.5,
			"angle":55,
			"shapes":[
				[150,10,150,-20]
			]
		},
	]

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
		if player.buttons[2]:
			player.position += Vector2(300*player.transform.x.x, -50)
			player._velocity = Vector2(100*player.transform.x.x, -200)
			player.anim_sprite.play("sideb2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer == 0:
		player.anim_sprite.play("sideb")
		
	if player.stateTimer < 10:
		player._velocity *= 0.8
		player._velocity.y -= 50
	elif player.stateTimer < 35:
		player._velocity *= 0.8

