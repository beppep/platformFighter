extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	endFrame = 33
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":8,
			"end":12,
			"kb":50,
			"kbscaling":0.1,
			"angle":-100,
			"shapes":[
				[22,26,-60,40]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("bair")
	if player.is_on_floor():
		interrupted = true


func onHit(name):
	if name=="1":
		endFrame = fastEndFrame
