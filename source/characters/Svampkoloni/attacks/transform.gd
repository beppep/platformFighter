extends "res://source/characters/Attack.gd"



func _init() -> void:
	
	endFrame = 16
	hitboxes = [
	]


func update():
	
	
	if player.stateTimer==0:
		player.anim_sprite.play("dsmash")
		if len(player.shroomList)>0:
			player.shroomList[-1].anim_sprite.play("grow")
	if player.stateTimer==10:
		if len(player.shroomList)>0:
			var pos = player.shroomList[-1].position + Vector2(0,-20)
			player.shroomList.pop_back().queue_free()
			
			player.createShroom(player.position, player.transform.x.x, false)
		
			player.position = pos

