extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 48
	fastEndFrame = 36
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":12,
			"start":19,
			"end":33,
			"kb":50,
			"kbscaling":1,
			"angle":45,
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
		if player.is_on_floor():
			hitboxes[0]["kbscaling"]=3
			hitboxes[0]["end"]=26
		else:
			hitboxes[0]["kbscaling"]=1.5
			hitboxes[0]["end"]=33
	if player.stateTimer==10:
		player._velocity = Vector2(800*player.scale.y, -600)


func onHit(name, target, shielded=false):
	get_parent()._velocity.y=-800#-400*int(name)

	if not shielded:
		endFrame = fastEndFrame
		
