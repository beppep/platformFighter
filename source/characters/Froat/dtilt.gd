extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 27
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":5,
			"end":12,
			"kb":150,
			"kbscaling":0.5,
			"angle":70,
			"shapes":[
				[28,12,43,30]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("dtilt")
		#player.groundfriction = 0.95
	if not player.is_on_floor():
		interrupted = true

func endAttack(player):
	if player.stateTimer == endFrame or interrupted:
		autoEndAttack(player)
		#player.groundfriction = 0.8 #original friction

func onHit(name):
	endFrame = fastEndFrame
