extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 18
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":6,
			"end":13,
			"kb":60,
			"kbscaling":1.5,
			"angle":45,
			"shapes":[
				[36,26,0,-10]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dattack")
	if player.stateTimer>5 and player.stateTimer<20:
		player._velocity.x = 500*player.transform.x.x
	if player.stateTimer==16:
		if player.buttons[1] or player.c_direction.x!=0:
			interrupted = true
			endAttack(false)
			player.attackWith("dattack")
			player.stateTimer = 5
			player.anim_sprite.play("standing") # reset?
			player.anim_sprite.play("dattack2") # reset?
	if not player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if player.buttons[1] or player.c_direction.x!=0:
			endAttack(false)
			player.attackWith("nair")
			player.stateTimer = 4
