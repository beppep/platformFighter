extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var shroom = load("res://source/characters/Svampkoloni/PoisonShroom.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 46
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fsmash")
	if player.stateTimer==20:
			
		var svamp = shroom.instance()
		svamp.position = player.position + Vector2(200*player.transform.x.x, 0)
		svamp.team = player.team
		svamp.transform.x.x = player.transform.x.x
		player.get_node("/root/Node2D/Articles").add_child(svamp)
		svamp.modulate = player.sprite_color
		svamp.anim_sprite.play("born")
		svamp.myOwner = self

