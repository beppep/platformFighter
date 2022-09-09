extends "res://source/characters/Attack.gd"



func _init() -> void:
	
	endFrame = 46
	hitboxes = [
	]


func update():
	
	if player.stateTimer==0:
		player.anim_sprite.play("db")
		if len(player.shroomList)>0:
			player.shroomList[-1].anim_sprite.play("grow")
			
	if player.stateTimer<24:
		player._velocity *= 0.5
	if player.stateTimer==24:
		player.createSpore(Vector2(0*player.transform.x.x,-20))
		randomize()
		for i in 45:
			player.createMoldSpore(Vector2(rand_range(-100, 100),rand_range(100,-100)))
			
		if len(player.shroomList)>0:
			var pos = player.shroomList[-1].position + Vector2(0,-20)
			player.shroomList.pop_back().queue_free()
			
			player.position = pos
			player.anim_sprite.play("dsmash")
		else:
			player.die(0)

