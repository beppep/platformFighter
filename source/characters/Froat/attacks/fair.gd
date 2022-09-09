extends Attack
class_name Fair

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 29
	fastEndFrame = 19
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":5,
			"end":7,
			"kb":70,
			"kbscaling":0.8,
			"angle":57,
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
