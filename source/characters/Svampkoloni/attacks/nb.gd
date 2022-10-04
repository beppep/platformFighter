extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 20
	fastEndFrame = 18
	hitboxes = [
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("db")
	if player.stateTimer==2:
		if len(player.shroomList)>0:
			print(player.shroomList)
			var shroom = player.shroomList[-1] #nullinstance !?
			shroom.state = 1
			shroom.stateTimer = 0
			shroom.currentAttack = shroom.myAttack.new()
			shroom.anim_sprite.play("attack")
			shroom.currentAttack.player = shroom
