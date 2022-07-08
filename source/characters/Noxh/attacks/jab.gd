extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 15
	fastEndFrame = 9
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":3,
			"end":5,
			"kb":30,
			"kbscaling":0.2,
			"angle":50,
			"shapes":[
				[17,17,33,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
	if not player.is_on_ground:
		pass
		#interrupted = true
