extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 49
	fastEndFrame = 37
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":14,
			"start":17,
			"end":18,
			"kb":160,
			"kbscaling":2,
			"angle":89,
			"shapes":[
				[37,30,15,-60]
			]
		},
		{
			"name":"1",
			"group":0,
			"damage":10,
			"start":17,
			"end":21,
			"kb":130,
			"kbscaling":1.7,
			"angle":88,
			"shapes":[
				[22,60,9,-90]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("usmash")
