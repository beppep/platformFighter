extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var bulletScene = load("res://source/characters/Noxh/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 22
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	player._velocity.x*=0.95
	player._velocity.y*=0.8
	player._velocity.y-=50
	if player.stateTimer==0:
		player.anim_sprite.play("downb")
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==10:
		
		var bullet = bulletScene.instance()
		bullet.position = player.position + Vector2(10,0)*player.transform.x.x
		bullet.team = player.team
		#player.bannedHitboxes.append([bullet,1])
		bullet.transform.x.x = player.transform.x.x
		bullet._velocity = Vector2(1000*player.transform.x.x,2000)
		$"/root/Node2D/Articles".add_child(bullet)
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 6


