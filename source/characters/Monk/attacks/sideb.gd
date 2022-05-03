extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":10,
			"end":12,
			"kb":40,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":1,
			"shapes":[
				[30,16,98,-8]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":20,
			"end":23,
			"kb":100,
			"kbscaling":0.5,
			"angle":145,
			"shapes":[
				[36,20,98,-8]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("fspec")
	if 10<=player.stateTimer and player.stateTimer<=13:
		if len(player.get_node("snatcher").get_overlapping_bodies())>0:
			grabbedWall = true
	if grabbedWall and player.stateTimer<23:
		player._velocity = Vector2.ZERO
	if grabbedWall and player.stateTimer==23:
		player._velocity = Vector2(1000*player.transform.x.x, -1000)
		grabbedWall = false
		endFrame = fastEndFrame

func onHit(name, target, shielded=false):
	var player = get_parent()
	if name=="0":
		#if not player.is_on_ground:
		#player._velocity.y*=0.4
		player._velocity.y=-500
	if name=="1":
		if not player.is_on_ground:
			player._velocity = Vector2(100*player.transform.x.x, -1000)
	if name=="1" and not shielded:
		endFast = true
