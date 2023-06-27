extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 12
	fastEndFrame = 12
	hitboxes = [
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.play("attach")
	if player._velocity.y>0:
		player._velocity.y = 0
