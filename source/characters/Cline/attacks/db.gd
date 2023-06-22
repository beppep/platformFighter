extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 48
	fastEndFrame = 38
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":11,
			"end":23,
			"kb":60,
			"kbscaling":0.5,
			"angle":33,
			"shapes":[
				[28,33,20,28]
			],
			"electric":8,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("db")
	if player.stateTimer<5:
		player.reverse()
	if player.stateTimer<10:
		player._velocity = Vector2(0, 0)
	if 10<player.stateTimer and player.stateTimer<25:
		player._velocity = Vector2(500*player.transform.x.x, 1500)
	if player.stateTimer==24 and player.buttons[2]:
		player._velocity *= 0.5
		
		interrupted = true
		endAttack(false)
		player.attackWith("db2")
		player.cant_hitfall = true
		player.stateTimer = -1
		
	if player.stateTimer>25:
		player.double_jumps = 1
		player._velocity *= 0.5
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 20

func onHit(name, target, shielded=false):
	#player._velocity.y=-1000
	
	if not shielded:
		#endFast = true
		endFast = true
		
