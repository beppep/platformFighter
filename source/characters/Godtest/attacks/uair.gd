extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 26
	fastEndFrame = 18
	hitboxes = [
		{
			"name":"0",
			"group":0,
			"damage":3,
			"start":5,
			"end":8,
			"kb":30,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":1,
			"shapes":[
				[20,40,20,-60]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":8,
			"start":10,
			"end":12,
			"kb":50,
			"kbscaling":1,
			"angle":-80,
			"shapes":[
				[24,44,20,-60]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("uair")
	if player.stateTimer==9:
		player.cant_hitfall = false
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10



func onHit(name, target, shielded=false):
	if name=="0":
		get_parent()._velocity.y=-200
	if name=="1":
		get_parent()._velocity.y=-1400
	if name=="1" and not shielded:
		endFast = true
