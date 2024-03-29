extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

func _init() -> void:
	endFrame = 300
	hitboxes = [
	]

func update():
	player._velocity *= 0
	if player.stateTimer==0:
		player.anim_sprite.play("recall")
	if player.stateTimer==10:
		if player.boardObject.state == 1:
			player.boardObject.currentAttack.interrupted = true
			player.boardObject.currentAttack.endAttack()
		player.boardObject.attackWith("recall")
	if player.hasHoverboard:
		interrupted = true
