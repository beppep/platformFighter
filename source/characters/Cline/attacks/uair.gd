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
			"group":0,
			"damage":8,
			"start":7,
			"end":10,
			"kb":124,
			"kbscaling":0.5,
			"angle":110,
			"shapes":[
				[30,40,50,-50]
			]
		},
	]

func onEnd():
	if endFast:
		pass#player.transform.x.x *= -1

func onHit(name, target, shielded=false):
	if name=="0":
		player._velocity.x=-300*player.transform.x.x
		player._velocity.y=-1100#-400*int(name)
	endFast = true

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10
