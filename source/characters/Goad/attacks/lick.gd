extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 54
	fastEndFrame = 36
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":14,
			"end":16,
			"kb":70,
			"kbscaling":0.1,
			"angle":50,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[22,22,100,-110]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":2,
			"start":17,
			"end":19,
			"kb":40,
			"kbscaling":0.1,
			"angle":50,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[22,22,150,-168]
			]
		},
		{
			"name":"2",
			"group":2,
			"damage":2,
			"start":20,
			"end":22,
			"kb":80,
			"kbscaling":0.3,
			"angle":-144,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[22,22,200,-220]
			]
		},
		{
			"name":"3",
			"group":2,
			"damage":4,
			"start":23,
			"end":26,
			"kb":60,
			"kbscaling":0.2,
			"angle":-144,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[22,22,150,-168]
			]
		},
		{
			"name":"4",
			"group":2,
			"damage":2,
			"start":27,
			"end":30,
			"kb":40,
			"kbscaling":0.1,
			"angle":-144,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[22,22,100,-110]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	player._velocity.x*=0.95
	player._velocity.y*=0.9
	player._velocity.y-=50
	if player.stateTimer==0:
		if player.is_on_ground:
			player.anim_sprite.play("lick")
		else:
			player.anim_sprite.play("lick")
		player.get_node("/root/Node2D/AudioStreamPlayer").playSound(player.get_node("/root/Node2D/AudioStreamPlayer").spew)
	if player.stateTimer < 6:
		player.reverse()
	#if 5<player.stateTimer and player.stateTimer<30:
	#	randomize()
	#	player.createMoldSpore(Vector2(randf_range(200, 400)*player.transform.x.x,randf_range(-300,-100)) + player._velocity*0.5)
		

