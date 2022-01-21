extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	endFrame = 24
	fastEndFrame = 15
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":5,
			"end":9,
			"kb":60,
			"kbscaling":0.1,
			"angle":120,
			"shapes":[
				[41,12,53,-20]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("lick")


func onHit(name):
	if name=="1":
		endFrame = fastEndFrame
