extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"




# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	
	endFrame = 33
	fastEndFrame = 23
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":5,
			"end":9,
			"kb":50,
			"kbscaling":1,
			"angle":45,
			"shapes":[
				[40,40,0,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":7,
			"start":10,
			"end":18,
			"kb":65,
			"kbscaling":1.1,
			"angle":55,
			"shapes":[
				[48,48,0,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.is_on_ground:
		interrupted = true
