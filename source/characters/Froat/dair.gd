extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 40
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":6,
			"end":10,
			"kb":70,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[24,24,10,60]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":7,
			"start":20,
			"end":26,
			"kb":100,
			"kbscaling":0.3,
			"angle":80,
			"shapes":[
				[24,24,10,60]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("dair")
	if player.is_on_floor():
		interrupted = true


func onHit(name):
	get_parent()._velocity.y=-800#-400*int(name)
	if name=="1":
		endFrame = fastEndFrame #warning
