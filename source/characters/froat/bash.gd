extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 40
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":17,
			"start":15,
			"end":17,
			"kb":90,
			"kbscaling":2,
			"angle":-30,
			"shapes":[
				[24,24,30,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":6,
			"start":18,
			"end":26,
			"kb":80,
			"kbscaling":0.5,
			"angle":30,
			"shapes":[
				[24,24,30,0]
			]
		},
		{
			"name":"2",
			"group":1,
			"damage":9,
			"start":15,
			"end":20,
			"kb":100,
			"kbscaling":1,
			"angle":120,
			"shapes":[
				[44,24,-70,20]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("bash")

