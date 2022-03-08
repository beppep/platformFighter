extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"




# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	
	endFrame = 34
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":10,
			"start":5,
			"end":8,
			"kb":120,
			"kbscaling":2.5,
			"angle":60,
			"shapes":[
				[30,20,20,10]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":8,
			"start":9,
			"end":19,
			"kb":100,
			"kbscaling":2,
			"angle":60,
			"shapes":[
				[40,30,15,15]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("nair")
	if player.is_on_ground:
		interrupted = true
