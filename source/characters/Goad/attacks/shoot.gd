extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 44
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
	if 5<player.stateTimer and player.stateTimer<30:
		randomize()
		player.createMoldSpore(Vector2(randf_range(200, 400)*player.transform.x.x,randf_range(-300,-100)) + player._velocity*0.5)
		


