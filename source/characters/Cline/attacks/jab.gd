extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 20
	fastEndFrame = 15
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":5,
			"end":8,
			"kb":50,
			"kbscaling":0.8,
			"angle":60,
			"shapes":[
				[33,33,55,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
	if not player.is_on_ground:
		pass
		interrupted = true
