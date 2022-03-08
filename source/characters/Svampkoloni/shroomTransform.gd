extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var shroom = load("res://source/characters/Svampkoloni/Svampkoloni.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 77
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("transform")
	if player.stateTimer==67:
		
		var svamp = shroom.instance()
		svamp.position = player.position + Vector2(0,-20)
		svamp.team = player.team
		svamp.player_id = player.player_id
		svamp.is_on_ground = true
		$"/root/Node2D/Players".add_child(svamp)
		
		player.queue_free()

