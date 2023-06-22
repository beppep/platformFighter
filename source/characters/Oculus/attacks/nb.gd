extends "res://source/characters/Attack.gd"


func _init() -> void:
	endFrame = 24
	fastEndFrame = 24
	hitboxes = [
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nb")
		
	if player.stateTimer==10:
		
		var ball = player.eyeballScene.instance()
		ball.position = player.position + Vector2(0*player.transform.x.x,-20)
		ball.team = player.team
		ball.player = player
		ball.transform.x.x = player.transform.x.x
		ball._velocity = player._velocity + Vector2(100*player.transform.x.x,-500)
		player.get_node("/root/Node2D/Articles").add_child(ball)
		player.eyeball = ball
		ball.anim_sprite.play("idle")
