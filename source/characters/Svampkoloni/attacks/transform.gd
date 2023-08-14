extends "res://source/characters/Attack.gd"

var tp_target

func _init() -> void:
	
	endFrame = 16
	hitboxes = [
	]


func update():
	
	
	if player.stateTimer==0:
		player.anim_sprite.play("dsmash")
		if len(player.shroomList)>0:
			tp_target = player.shroomList[-1]
			tp_target.anim_sprite.play("grow")
	if player.stateTimer==10:
		if len(player.shroomList)>0:
			if not is_instance_valid(tp_target):
				tp_target = player.shroomList[-1]
			var pos = tp_target.position + Vector2(0,-10)
			player.shroomList.erase(tp_target)
			tp_target.queue_free()
			
			player.createShroom(player.position, player.transform.x.x, false)
		
			player.position = pos

