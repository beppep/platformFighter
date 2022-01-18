extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 53
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":17,
			"start":18,
			"end":20,
			"kb":100,
			"kbscaling":2,
			"angle":-30,
			"shapes":[
				[24,24,40,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":6,
			"start":21,
			"end":34,
			"kb":50,
			"kbscaling":0.5,
			"angle":30,
			"shapes":[
				[24,24,40,0]
			]
		},
	]

func update(player):
	autoAttack(player.stateTimer)
	if player.stateTimer==0:
		print("b")
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("bash")


func onHit():
	pass
