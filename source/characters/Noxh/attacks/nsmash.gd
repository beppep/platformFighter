extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 50
	fastEndFrame = 40
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":15,
			"start":13,
			"end":18,
			"kb":60,
			"kbscaling":2,
			"angle":90,
			"shapes":[
				[10,40,0,-10]
			]
		},
		{
			"name":"1",
			"group":0,
			"damage":15,
			"start":13,
			"end":18,
			"kb":60,
			"kbscaling":2,
			"angle":120,
			"shapes":[
				[10,30,-30,0]
			]
		},
		{
			"name":"2",
			"group":0,
			"damage":15,
			"start":13,
			"end":18,
			"kb":60,
			"kbscaling":2,
			"angle":60,
			"shapes":[
				[10,30,30,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nsmash")
