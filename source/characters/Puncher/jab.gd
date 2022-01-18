extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	endFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":3,
			"end":7,
			"kb":50,
			"kbscaling":0.3,
			"angle":30,
			"shapes":[
				[21,20,43,-5]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":7,
			"start":12,
			"end":16,
			"kb":100,
			"kbscaling":1,
			"angle":60,
			"shapes":[
				[21,28,103,-9]
			]
		}
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player.stateTimer)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("punchin")


func onHit():
	pass
