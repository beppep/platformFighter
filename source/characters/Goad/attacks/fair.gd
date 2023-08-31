extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 30
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":5,
			"end":8,
			"kb":66,
			"kbscaling":1.3,
			"angle":60,
			"shapes":[
				[41,32,44,34]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10
