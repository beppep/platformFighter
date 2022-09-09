extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 38
	hitboxes = [
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.play("reborn")
