extends "res://source/characters/Attack.gd"



var charging = 0

func _init():
	can_grabcancel = false
	endFrame = 45
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":16,
			"end":19,
			"kb":50,
			"kbscaling":0.5,
			"angle":90,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,0,-30]
			],
		},
	]

func update():
	if player.stateTimer==0 and not charging:
		player.anim_sprite.play("usmash")
		#player.cant_hitfall=true
	
	if player.stateTimer == 10:
		if player.buttons[2] and charging < 10:
			player.stateTimer = -1
			player.anim_sprite.play("usmash")
			player.anim_sprite.play("usmashc")
			charging += 1
	if player.stateTimer < 15 and charging:
		if not player.buttons[2]:
			player.anim_sprite.play("usmashnc")
			player.stateTimer = 15
	if player.stateTimer == 15:
			player.anim_sprite.play("usmashnc")
	
	if player.stateTimer < 20:
		player._velocity *= 0.9
		player._velocity.y -= 80

func onHit(name, target, shielded=false):
	#if target.getGrabbed():
		
	interrupted = true
	endAttack(false)
	
	player.attackWith("usmash2")
	#player.cant_hitfall = true
	player.stateTimer = -1
	player.grab_target = target

