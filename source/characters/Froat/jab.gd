extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 20
	fastEndFrame = 14
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":3,
			"end":5,
			"kb":40,
			"kbscaling":0.2,
			"angle":60,
			"shapes":[
				[28,14,48,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("jab")


func onHit(name, target):
	if name=="0":
		endFrame = fastEndFrame
