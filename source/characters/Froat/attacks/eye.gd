extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var plat = load("res://source/things/platform.tscn")
var eye = load("res://source/fx/goateye.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	endFrame = 20
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("standing")
	if player.stateTimer<20:
		player._velocity = Vector2(0,0)
	if player.stateTimer==10:
		var goateye = eye.instance()
		#goateye
		goateye.position = player.position
		goateye.scale = Vector2(2, 2)
		get_node("/root/Node2D/fx").add_child(goateye)
		goateye.z_index = 2
		
		var platform = plat.instance()
		platform.position = player.position+Vector2(0,50)
		$"/root/Node2D/ground/".add_child(platform)


