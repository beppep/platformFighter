extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 70
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":25,
			"end":28,
			"kb":100,
			"kbscaling":0.5,#2.5?
			"angle":90,
			"shapes":[
				[50,50,0,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("upb")
	if player.stateTimer<25:
		player._velocity = Vector2.ZERO
	elif player.stateTimer==25:
		player.position += player.direction*250
		player._velocity = Vector2(0,-1000)
	elif player.stateTimer>25:
		player._velocity *=0.9
		player.can_walljump = true
	if player.is_on_ground and player.stateTimer>28:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 28

