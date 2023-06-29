extends "res://source/characters/Attack.gd"

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target

# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 38
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":10,
			"end":12,
			"kb":140,
			"kbscaling":0.1,
			"angle":85,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[30,30,30,0]
			]
		},
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.play("throw")
		player.cant_hitfall=true
	if player.stateTimer<10:
		player.grab_target.position = player.position+Vector2(50*player.transform.x.x,0)
		player.grab_target._velocity = player._velocity
		
	if player.stateTimer == 18 or player.stateTimer == 28:
		var bullet = player.bulletScene.instantiate()
		bullet.position = player.position + Vector2(0,-20)
		bullet.team = player.team
		bullet.transform.x.x = player.transform.x.x
		bullet._velocity = Vector2((30-player.stateTimer)*100*player.transform.x.x,-2000)
		player.get_node("/root/Node2D/Articles").add_child(bullet)
		bullet.attackWith("bulletAttack2")

func onHit(name, target, shielded=false):
	pass
