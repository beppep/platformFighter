extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var shroom = load("res://source/characters/Svampkoloni/shroom.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 64
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("utilt")
	if player.stateTimer<22:
		player._velocity *= 0.8
	if player.stateTimer==22:
		player._velocity.y = -1000
		
		var svamp = shroom.instance()
		svamp.position = player.position
		svamp.team = player.team
		svamp.player_id = player.player_id
		svamp.transform.x.x = player.transform.x.x
		svamp._velocity = Vector2(200*player.transform.x.x,-1500)
		$"/root/Node2D/Articles".add_child(svamp)
		svamp.modulate = player.sprite_color
		
		svamp.anim_player.play("jump")

