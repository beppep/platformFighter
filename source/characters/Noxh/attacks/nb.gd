extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

func _init() -> void:
	can_grabcancel=false
	endFrame = 58
	fastEndFrame = 38 # for second hit
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":8,
			"end":16,
			"kb":60,
			"kbscaling":0.1,
			"angle":95,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[34,44,40,10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":7,
			"start":30,
			"end":32,
			"kb":70,
			"kbscaling":1.4,
			"angle":-73,
			"shapes":[
				[24,40,38,10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nb")
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer<48:
		player._velocity.x *= 0.9
		player._velocity.y *= 0.9
		player._velocity.y -= 60
	if player.stateTimer==20 and endFast:
		hitboxes[1]["start"] = 24
		hitboxes[1]["end"] = 26
	if player.stateTimer==26 and not endFast or player.stateTimer==20 and endFast:
		if (player.buttons[2] and player.direction == Vector2.ZERO):
			player.anim_sprite.play("nb2")
		else:
			interrupted = true
