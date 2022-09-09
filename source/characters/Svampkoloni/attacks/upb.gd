extends "res://source/characters/Attack.gd"




# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 64
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("upb")
	if player.stateTimer<12:
		player._velocity *= 0.9
		player._velocity.y -= 100
		
	if player.stateTimer==29:
		player._velocity.y = 1000
		pass
		
	if player.stateTimer==28:
		player.createSpore(Vector2(200*player.transform.x.x,-1200))
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 25
