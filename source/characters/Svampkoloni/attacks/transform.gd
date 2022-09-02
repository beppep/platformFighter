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
func update():
	player._velocity *= 0.5
	
	if player.stateTimer==0:
		player.anim_sprite.play("db")
		if len(player.shroomList)>0:
			player.shroomList[-1].anim_sprite.play("grow")
	if player.stateTimer==40:
		if len(player.shroomList)>0:
			var pos = player.shroomList[-1].position
			player.shroomList.pop_back().queue_free()
			
			
			if player.is_on_ground:
				player.createShroom(player.position, player.transform.x.x, false)
		
			player.position = pos

