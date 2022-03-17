extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 48
	fastEndFrame = 36
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":12,
			"start":19,
			"end":33,
			"kb":140,
			"kbscaling":4,
			"angle":55,
			"shapes":[
				[28,28,30,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("ramm")
	if player.stateTimer==10:
		player._velocity = Vector2(800*player.scale.y, -600)
	if player.stateTimer==36:
		player.can_walljump = true


func onHit(name, target, shielded=false):
	get_parent()._velocity.y=-1000
	get_parent()._velocity.x*=0.9

	if not shielded:
		endFast = true
		
