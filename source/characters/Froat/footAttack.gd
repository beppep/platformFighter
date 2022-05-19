extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 33
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"start":3,
			"end":15,
			"damage":14,
			"kb":100,
			"kbscaling":2,
			"angle":90,
		},
	]
	

func changeHitbox():
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"start":3,
			"end":15,
			"damage":14,
			"kb":100,
			"kbscaling":3,
			"angle":-90,
		},
	]

func update(player):
	if player.stateTimer==16:
		player._velocity *= 0
		player.intangible = false

func onHit(name, target, shielded=false):
	if not shielded:
		owner.get_node("currentAttack").endFast = true
