extends Attack
#class_name Fair



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 42
	fastEndFrame = 32
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":15,
			"end":18,
			"kb":70,
			"kbscaling":1.5,
			"angle":-80,
			"shapes":[
				[44,28,0,66]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dair")
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 15
