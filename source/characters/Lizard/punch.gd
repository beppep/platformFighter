extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	endFrame = 23
	fastEndFrame = 15
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":5,
			"end":8,
			"kb":80,
			"kbscaling":0.3,
			"angle":60,
			"shapes":[
				[21,20,43,-5]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("punch")


func onHit(name, target):
	if name=="0":
		endFrame = fastEndFrame
