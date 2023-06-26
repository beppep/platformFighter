extends "res://source/characters/Attack.gd"



func _init() -> void:
	endFrame = 70
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":6,
			"end":20,
			"kb":100,
			"kbscaling":0.2,
			"angle":50,
			"shapes":[
				[40,40,20,-10]
			]
		},
	]


func update():
	if player.stateTimer==0:
		player.anim_sprite.play("upb")
	if player.stateTimer<5:
		player.reverse()
		player._velocity = Vector2.ZERO
	elif player.stateTimer>=5 and player.stateTimer<=10:
		player._velocity.x = player.transform.x.x*500
		if player.stateTimer == 5:
			player._velocity.y = -1000
	if player.is_on_ground and player.stateTimer>20:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 25

