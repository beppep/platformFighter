extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 60
	fastEndFrame = 44
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":8,
			"end":10,
			"kb":24,
			"kbscaling":0.1,
			"angle":88,
			"autolinkX":0.9,
			"shapes":[
				[25,50,55,5]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":4,
			"start":20,
			"end":22,
			"kb":24,
			"kbscaling":0.1,
			"angle":88,
			"autolinkX":0.9,
			"shapes":[
				[25,50,55,5]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":7,
			"start":32,
			"end":35,
			"kb":96,
			"kbscaling":1.3,
			"angle":66,
			"shapes":[
				[25,50,55,5]
			]
		},
	]

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
		if name == "2":
			player._velocity.y = -900
		else:
			player._velocity.y = -200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer == 0:
		player.anim_sprite.play("fb")

	if player._velocity.y > 200:
		player._velocity.y *= 0.9
