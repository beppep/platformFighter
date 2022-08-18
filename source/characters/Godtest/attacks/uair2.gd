extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 44
	fastEndFrame = 34
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
			"shapes":[
				[20,40,33,-100]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":25,
			"end":27,
			"kb":100,
			"kbscaling":1,
			"angle":-100,
			"shapes":[
				[24,44,33,-100]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair2")
	if 10<=player.stateTimer and player.stateTimer<=13:
		if len(player.get_node("snatcher2").get_overlapping_bodies())>0:
			grabbedWall = true
	if grabbedWall and player.stateTimer<27:
		player._velocity = Vector2.ZERO
	if grabbedWall and player.stateTimer==27:
		player._velocity = Vector2(100*player.transform.x.x, -2500)
		grabbedWall = false
		endFrame = fastEndFrame

func onHit(name, target, shielded=false):
	var player = get_parent()
	if name=="0":
		player._velocity.x*=0.4
		if not player.is_on_ground:
			player._velocity.y*=0.3
			player._velocity.y-=1000
	if name=="1":
		if not player.is_on_ground:
			player._velocity = Vector2(100*player.transform.x.x, -2500)
	if name=="1" and not shielded:
		endFast = true
