extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 23
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":10,
			"start":3,
			"end":8,
			"kb":100,
			"kbscaling":1,
			"angle":60,
			"shapes":[
				[24,44,-80,0]
			]
		}
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("hair")


func onHit():
	pass
