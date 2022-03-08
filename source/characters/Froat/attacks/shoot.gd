extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var arrow = load("res://source/characters/Froat/arrow.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 20
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("jab")
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==10:
		
		var arow = arrow.instance()
		arow.position = player.position
		arow.team = player.team
		arow.transform.x.x = player.transform.x.x
		arow._velocity = Vector2(400*player.transform.x.x,-200) + player._velocity
		$"/root/Node2D/Articles".add_child(arow)


