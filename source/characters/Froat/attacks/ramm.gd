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
			"damage":12,
			"start":18,
			"end":20,
			"kb":120,
			"kbscaling":1.3,
			"angle":30,
			"shapes":[
				[28,28,30,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":8,
			"start":21,
			"end":27,
			"kb":100,
			"kbscaling":0.9,
			"angle":35,
			"shapes":[
				[20,20,20,0]
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
	"""
	if player.stateTimer>20 and player.is_on_wall():
		player._velocity=Vector2(-800*player.transform.x.x,-1000)
		#player.transform.x.x *=-1
	"""
	if player.stateTimer>12:
		if player.is_on_ground:
			wasGrounded = true
		if not player.is_on_ground and wasGrounded:
			interrupted = true #remove hitboxes? idk


func onHit(name, target, shielded=false):
	player._velocity.y=-1000
	player._velocity.x*=0.5

	if not shielded:
		endFast = true
		
