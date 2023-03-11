extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var bulletScene = load("res://source/characters/Noxh/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 55
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":38,
			"end":41,
			"kb":70,
			"kbscaling":1.9,
			"angle":80,
			"shapes":[
				[44,28,0,20]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		player._velocity = Vector2(0,0)
		player.anim_sprite.play("dsmash")
	if 12<player.stateTimer and player.stateTimer<32:
		player.intangible = true
		player.move_and_collide(Vector2(player.direction.x*10,0))
		if not player.move_and_collide(Vector2(0,50)):
			player.move_and_collide(Vector2(0,-50))
			player.position.x -= player.direction.x*10
	if player.stateTimer==32:
		player.intangible = false
		

