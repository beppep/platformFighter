extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var boulderScene = load("res://source/things/boulder.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 48
	fastEndFrame = 38
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":10,
			"start":16,
			"end":19,
			"kb":100,
			"kbscaling":1,
			"angle":90,
			"shapes":[
				[20,35,0,0],
				[30,30,0,0],
				[35,20,0,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("stunned")
	if player.stateTimer < 19:
		player._velocity *= 0.9
		player._velocity.y -= 0
	if player.stateTimer==19:
		
		var boulder = boulderScene.instance()
		boulder.position = (player.position)
		boulder._velocity = (player._velocity*0+Vector2(0,-20))
		boulder.team = player.team
		boulder.bannedHitboxes = [[self,1]]
		$"/root/Node2D/Articles".add_child(boulder)


func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
	var ang = (get_parent().position-target.position).angle() #position.angle_to_point(target.position)
	target.kb_vector += -Vector2(cos(ang),sin(ang))*target.kb_vector.length()*0.5
