extends "res://source/characters/Attack.gd"


var spore = load("res://source/characters/Svampkoloni/spore.tscn")


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
		
	if player.stateTimer==22:
		player._velocity.y = 1000
		
	if player.stateTimer==21:
		
		var svamp = spore.instance()
		svamp.position = player.position
		svamp.team = player.team
		svamp.transform.x.x = player.transform.x.x
		svamp._velocity = Vector2(100*player.transform.x.x,-1200) + player._velocity
		player.get_node("/root/Node2D/Articles").add_child(svamp)
		svamp.attackWith("sporeAttack")
		svamp.modulate = player.sprite_color
		svamp.anim_sprite.play("spore")
		svamp.myOwner = player
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 19
