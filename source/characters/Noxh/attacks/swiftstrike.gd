extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":11,
			"end":15,
			"kb":50,
			"kbscaling":0.5,
			"angle":80,
			"shapes":[
				[40,20,-20,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer == 0:
		player.anim_sprite.play("sideb")
	if player.stateTimer < 10:
		player._velocity *= 0.5
	elif player.stateTimer < 15:
		player._velocity = Vector2(3600*player.transform.x.x,player.direction.y*500)
	elif player.stateTimer == 15:
		player._velocity = Vector2(500*player.transform.x.x,0)
	elif player.stateTimer < 20:
		player._velocity *= 0.9
		#player.can_walljump = true
	if player.is_on_ground and player.stateTimer>15:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = endFrame - player.stateTimer

