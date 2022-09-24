extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"




# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	
	endFrame = 60
	fastEndFrame = 50
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":5,
			"end":8,
			"kb":60,
			"kbscaling":0.2,
			"angle":111,
			"shapes":[
				[30,30,40,13]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":8,
			"start":13,
			"end":17,
			"kb":80,
			"kbscaling":1,
			"angle":180,
			"shapes":[
				[40,30,-55,15]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":7,
			"start":21,
			"end":24,
			"kb":80,
			"kbscaling":1,
			"angle":60,
			"shapes":[
				[20,30,40,-55]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":4,
			"start":29,
			"end":32,
			"kb":80,
			"kbscaling":0.4,
			"angle":80,
			"shapes":[
				[20,30,-25,66]
			]
		},
		{
			"name":"4",
			"group":5,
			"damage":8,
			"start":37,
			"end":41,
			"kb":80,
			"kbscaling":1,
			"angle":45,
			"shapes":[
				[30,30,50,-25]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	player._velocity.y *= 0.97
	player._velocity.y -= 20
	if player.stateTimer==0:
		player.anim_sprite.play("spinair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 19
