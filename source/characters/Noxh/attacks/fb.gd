extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 50
	fastEndFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":12,
			"end":15,
			"kb":70,
			"kbscaling":0.7,
			"angle":60,
			"shapes":[
				[150,20,150,-20]
			]
		},
	]

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer == 0:
		player.anim_sprite.play("sideb")
		
	if player.stateTimer == 16:
		if endFast == true:
			player.position += Vector2(300*player.transform.x.x, -50)
			player._velocity = Vector2(100*player.transform.x.x, -200)
			player.anim_sprite.play("sideb2")
		
	if player.stateTimer < 10:
		player._velocity *= 0.8
		player._velocity.y -= 50
	elif player.stateTimer < 45:
		player._velocity *= 0.7

