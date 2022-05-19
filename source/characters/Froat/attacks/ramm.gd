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
			"start":19,
			"end":23,
			"kb":140,
			"kbscaling":3.1,
			"angle":55,
			"shapes":[
				[28,28,30,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":8,
			"start":24,
			"end":30,
			"kb":120,
			"kbscaling":1.1,
			"angle":55,
			"shapes":[
				[20,20,20,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player._velocity *= 0.5
		player.anim_sprite.play("sideb")
		wasGrounded = false
	if player.stateTimer==10:
		player._velocity = Vector2(800*player.transform.x.x, -600)
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
	get_parent()._velocity.y=-1000
	get_parent()._velocity.x*=0.9

	if not shielded:
		endFast = true
		
