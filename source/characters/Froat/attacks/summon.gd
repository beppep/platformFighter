extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var footScene = load("res://source/characters/Froat/foot.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 34
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("stunned")
		player._velocity*=0.8
	if player.stateTimer==1:
		
		var foot = footScene.instance()
		foot.position = Vector2(player.position.x, 1000)
		foot.team = player.team
		foot.scale.x = player.scale.y
		$"/root/Node2D/Articles".add_child(foot)


