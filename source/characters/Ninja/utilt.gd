extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 24
	fastEndFrame = 16
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":7,
			"end":13,
			"kb":100,
			"kbscaling":2,
			"angle":90,
			"shapes":[
				[24,24,0,-80]
			]
		}
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("utilt")

func onHit(name):
	if name=="0":
		endFrame = fastEndFrame #warning
