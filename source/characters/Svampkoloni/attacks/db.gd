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
			
	if player.stateTimer<20:
		player._velocity *= 0.5
	if player.stateTimer==20:
		player.createSpore(Vector2(0*player.transform.x.x,0))
			
		if len(player.shroomList)>0:
			var pos = player.shroomList[-1].position + Vector2(0,-20)
			player.shroomList.pop_back().queue_free()
			
			player.position = pos
			player.anim_sprite.play("dsmash")
		else:
			player._velocity.y = -600

