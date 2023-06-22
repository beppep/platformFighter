extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 15
	fastEndFrame = 11
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":3,
			"end":6,
			"kb":30,
			"kbscaling":1,
			"angle":10,
			"shapes":[
				[23,13,25,-5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
	if not player.is_on_ground:
		pass
		interrupted = true
