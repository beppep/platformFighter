extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var footScene = load("res://source/characters/Froat/foot.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 28
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("stunned")
		player._velocity*=0.8 # !?
	if player.stateTimer==1:
		
		var foot = footScene.instantiate()
		foot.position = Vector2(player.position.x+player._velocity.x*0.1, 750)
		foot.team = player.team
		foot.scale.x = player.scale.y
		$"/root/Node2D/Articles".add_child(foot)
		
		var foot2 = footScene.instantiate()
		foot2.position = Vector2(player.position.x+player._velocity.x*0.1, -750)
		foot2.transform.y.y = -1
		foot2._velocity.y *= -1
		foot2.upsideDown = true
		foot2.changeHitbox() #only for feet (?
		foot2.team = player.team
		foot2.scale.x = player.scale.y
		$"/root/Node2D/Articles".add_child(foot2)


