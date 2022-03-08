extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 99
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer<50:
		player._velocity.y = -500
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("roll")
	if player.stateTimer==56:
		player.can_walljump = true

