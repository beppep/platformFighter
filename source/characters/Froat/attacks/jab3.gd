extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 31
	fastEndFrame = 23
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":5,
			"end":7,
			"kb":30,
			"kbscaling":0.2,
			"angle":200,
			"shapes":[
				[28,16,50,-10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":10,
			"end":12,
			"kb":30,
			"kbscaling":0.2,
			"angle":7,
			"shapes":[
				[15,23,50,-2]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab3")
	if not player.is_on_ground:
		interrupted = true

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
		if player.percentage>0:
			player.percentage-=1
