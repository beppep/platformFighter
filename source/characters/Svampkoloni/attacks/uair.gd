extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":10,
			"end":12,
			"kb":50,
			"kbscaling":0.5,
			"angle":-1,
			"autolinkX":0.9,
			"autolinkY":1,
			"shapes":[
				[30,35,-5,-37]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":13,
			"end":15,
			"kb":50,
			"kbscaling":0.5,
			"angle":-1,
			"autolinkX":0.9,
			"autolinkY":1,
			"shapes":[
				[30,35,-5,-37]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":10,
			"start":16,
			"end":18,
			"kb":70,
			"kbscaling":1.3,
			"angle":90,
			"shapes":[
				[30,35,-5,-37]
			]
		}
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if 10< player.stateTimer and  player.stateTimer<22:
		if player._velocity.y > 0:
			player._velocity.y *= 0.8
			player._velocity.y -= 60
	if player.stateTimer==22:
		randomize()
		for i in 40:
			player.createMoldSpore(Vector2(randf_range(-100, 100)+player._velocity.x*0.2,randf_range(0,-100)))
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 20
