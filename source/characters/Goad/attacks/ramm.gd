extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var wasGrounded = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 48
	fastEndFrame = 36
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":18,
			"end":24,
			"kb":60,
			"kbscaling":0.4,
			"angle":-1,
			"autolinkX":1,
			"autolinkY":1,
			"shapes":[
				[30,30,40,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":8,
			"start":25,
			"end":27,
			"kb":40,
			"kbscaling":1.0,
			"angle":20,
			"shapes":[
				[40,40,50,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("sideb")
		wasGrounded = false
	if player.stateTimer<10:
		player._velocity *= 0.0
	if player.stateTimer==10:
		player._velocity = Vector2(600*player.transform.x.x, -600)
	if player.stateTimer>10 and player.stateTimer<20:
		player._velocity.x = 600*player.transform.x.x
	if player.stateTimer==36:
		player.can_walljump = true
		if not endFast:
			player._velocity.x*=0.8
	if player.stateTimer>12:
		if player.is_on_ground:
			wasGrounded = true
		if not player.is_on_ground and wasGrounded:
			interrupted = true #remove hitboxes? idk


func onHit(name, target, shielded=false):
	if name=="1":
		player._velocity.y=-800
		player._velocity.x*=0.5

	if not shielded:
		endFast = true
		
