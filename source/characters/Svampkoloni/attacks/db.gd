extends "res://source/characters/Attack.gd"

var tp_target

func _init() -> void:
	
	
	endFrame = 46
	hitboxes = [
	]


func update():
	
	if player.stateTimer==0:
		player.anim_sprite.play("db")
		if len(player.shroomList)>0:
			tp_target = player.shroomList[-1]
			tp_target.anim_sprite.play("grow")
			
	if player.stateTimer<24:
		player._velocity *= 0.5
	if player.stateTimer==24:
		player.createSpore(Vector2(0*player.transform.x.x,-50))
		randomize()
		for i in 45:
			player.createMoldSpore(Vector2(rand_range(-100, 100),rand_range(200,-100)))
			
		if tp_target:
			var pos = tp_target.position + Vector2(0,-20)
			player.shroomList.erase(tp_target)
			tp_target.queue_free()
			
			player.position = pos
			player.anim_sprite.play("dsmash")
		else:
			player.die(0)

