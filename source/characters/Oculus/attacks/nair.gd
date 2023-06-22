extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 18
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":6,
			"end":8,
			"kb":30,
			"kbscaling":0.8,
			"angle":55,
			"autolinkX":0.8,
			"autolinkY":0.8,
			"shapes":[
				[32,32,0,0]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.stateTimer==5:
		player.anim_sprite.play("nair") # reset?
		player.anim_sprite.play("nair2")
	if player.stateTimer==11:
		if player.buttons[1] or player.c_direction.x!=0:
			interrupted = true
			endAttack(false)
			player.attackWith("nair")
			player.stateTimer = 4
			player.currentAttack.endFast = endFast
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 15
