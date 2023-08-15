extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 55
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	player._velocity.x*=0.95
	player._velocity.y*=0.9
	player._velocity.y-=50
	if player.stateTimer==0:
		if player.is_on_ground:
			player.anim_sprite.play("shoot")
		else:
			player.anim_sprite.play("shoot")
		player.get_node("/root/Node2D/AudioStreamPlayer").playSound(player.get_node("/root/Node2D/AudioStreamPlayer").spew)
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==24:
		
		var rock = player.rockScene.instantiate()
		rock.position = player.position + Vector2(10,0)*player.transform.x.x
		rock.team = player.team
		player.bannedHitboxes.append([rock,1])
		rock.transform.x.x = player.transform.x.x
		rock._velocity = Vector2(300*player.transform.x.x,-600) + player._velocity
		player.get_node("/root/Node2D/Articles").add_child(rock)
		


