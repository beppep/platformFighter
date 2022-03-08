extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var shroom = load("res://source/characters/Svampkoloni/shroom.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 46
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	player._velocity *= 0.5
	
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("transform")
	if player.stateTimer==40:
		
		var svamp = shroom.instance()
		svamp.position = player.position + Vector2(0,10)
		svamp.team = player.team
		svamp.player_id = player.player_id
		if player.is_on_ground:
			svamp._velocity = Vector2(0,1)
		else:
			svamp._velocity = Vector2(0*player.transform.x.x,-100)
		svamp.is_on_ground = player.is_on_ground
		$"/root/Node2D/Articles".add_child(svamp)
		svamp.modulate = player.sprite_color
		
		player.queue_free()

