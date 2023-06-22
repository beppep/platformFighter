extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 33
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":9,
			"start":7,
			"end":11,
			"kb":70,
			"kbscaling":1.2,
			"angle":90,
			"shapes":[
				[30,20,0,-30]
			]
		},
	]


func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 10
