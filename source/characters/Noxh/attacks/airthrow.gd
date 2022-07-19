extends "res://source/characters/Attack.gd"

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var target

# Called when the node enters the scene tree for the first time.
func _init():
	can_grabcancel = false
	endFrame = 29
	fastEndFrame = 29
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":10,
			"end":12,
			"kb":120,
			"kbscaling":0.2,
			"angle":70,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[30,30,30,0]
			]
		},
	]

func update():
	player._velocity*=0.9
	player._velocity.y-=50
		
	if player.stateTimer==1:
		player.anim_sprite.play("throw")
		player.cant_hitfall=true
	if player.stateTimer<10:
		player.grab_target.position = player.position+Vector2(50*player.transform.x.x,0)
		player.grab_target._velocity = player._velocity
		
	if player.stateTimer == 15:
		var bullet = player.bulletScene.instance()
		bullet.position = player.position + Vector2(0,-20)
		bullet.team = player.team
		bullet.transform.x.x = player.transform.x.x
		bullet._velocity = Vector2(800*player.transform.x.x,-1500)+player._velocity
		player.get_node("/root/Node2D/Articles").add_child(bullet)
		bullet.attackWith("bulletAttack2")
