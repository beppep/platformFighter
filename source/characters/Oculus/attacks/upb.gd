extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 48
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":13,
			"end":18,
			"kb":40,
			"kbscaling":0.7,
			"angle":90,
			"autolinkX":0.8,
			"autolinkY":0.8,
			"shapes":[
				[32,16,0,-30]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("upb")
	if player.stateTimer<10:
		if player._velocity.y > 0:
			player._velocity.y *= 0.5
	if player.stateTimer==11:
		player.anim_sprite.play("upb") # reset?
		player.anim_sprite.play("upb2")
	if player.stateTimer>10 and player.stateTimer<=20:
		if player._velocity.y > -500:
			player._velocity.y -= 100
	if player.stateTimer==40-player.upB_charge*2: # originally 20
		if player.buttons[2] and player.upB_charge > 0:
			player.upB_charge -= 1
			interrupted = true
			endAttack(false)
			player.attackWith("ub")
			player.stateTimer = 10
			player.currentAttack.endFast = true
	if player.is_on_ground and player.stateTimer>20:
		interrupted = true #remove hitboxes? idk
		print("how")
		if not endFast:
			landingLag = 25
			

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
		player.double_jumps = 1
