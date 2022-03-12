extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 55
	fastEndFrame = 50 #?
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":16,
			"end":33,
			"kb":150,
			"kbscaling":2,
			"angle":-90,
			"shapes":[
				[28,22,0,23]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("upb")
	if player.stateTimer<16:
		player._velocity = Vector2(0, -60)
	if player.stateTimer==16:
		player._velocity = Vector2(0, 1500)
	if player.stateTimer==33:
		player._velocity *= 0.0
	if player.is_on_floor():
		interrupted = true


func onHit(name, target, shielded=false):
	get_parent()._velocity.y=-1500
	get_parent()._velocity.x*=0.9

	if not shielded:
		#endFast = true
		interrupted = true
		
