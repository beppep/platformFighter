extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 36
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":11,
			"end":14,
			"kb":30,
			"kbscaling":0.8,
			"angle":55,
			"autolinkX":0.8,
			"autolinkY":0.8,
			"shapes":[
				[30,30,0,10]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fb")
	if player.stateTimer==11:
		player.noFriction = true
		player.anim_sprite.play("fb") # reset?
		player.anim_sprite.play("fb2")
	if player.stateTimer==15:
		if player.buttons[2]:
			interrupted = true
			endAttack(false)
			player.attackWith("fb")
			player.stateTimer = 10
			player.currentAttack.endFast = endFast
			player.noFriction = true
	
	if player.stateTimer>10 and player.stateTimer<16:
		if player.is_on_ground:
			player._velocity.x += player.transform.x.x*40
	
		
		
func onHit(name, target, shielded=false):
	if not shielded:
		player._velocity.y = -1000
		player._velocity.x *= 0.5
		endFast = true
		
func onEnd():
	player.noFriction = false
