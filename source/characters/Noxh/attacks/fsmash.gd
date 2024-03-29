extends Attack


# Called when the node enters the scene tree for the first time.

func _init() -> void:
	endFrame = 77
	fastEndFrame = 70
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":17,
			"end":20,
			"kb":150,
			"kbscaling":2.0,
			"angle":40,
			"shapes":[
				[50,26,95,-25]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":5,
			"start":54,
			"end":62,
			"kb":60,
			"kbscaling":0.3,
			"angle":70,
			"shapes":[
				[20,40,34,-30]
			]
		},
	]

func update():
	if player.stateTimer<50:
		player._velocity.y *= 0.8
	
	if player.stateTimer==0:
		player.anim_sprite.play("fsmash")
	if player.stateTimer==38 and player.grab_target:
		player.anim_sprite.play("fsmash2")
	if player.stateTimer==50 and player.buttons[2]:
		if player.grab_target and is_instance_valid(player.grab_target) and player.grab_target.position:
			var target_pos = player.grab_target.position + player.grab_target._velocity*0.15 + Vector2(0,100)
			if not(abs(target_pos.x) > player.get_node("/root/Node2D").blastzoneX-100):
				player.position = target_pos
				player.transform.x.x *= -1
			else:
				interrupted=true
		else:
			interrupted=true
	if player.stateTimer>49 and player.stateTimer<53 and player.grab_target and is_instance_valid(player.grab_target):
		player._velocity = Vector2(400*player.transform.x.x, -1100)
		
		
func onHit(name, target, shielded=false):
	if name=="0" and not shielded:
		player.grab_target = target

	if not shielded:
		endFast = true
