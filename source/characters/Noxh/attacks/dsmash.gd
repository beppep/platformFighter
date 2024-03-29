extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var bulletScene = load("res://source/characters/Noxh/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 55
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	player._velocity.y *= 0.8
	if player.stateTimer==0:
		player.anim_sprite.play("dsmash")
	if player.stateTimer==12:
		
		var bullet = bulletScene.instantiate()
		bullet.position = player.position + Vector2(10,0)*player.transform.x.x
		bullet.team = player.team
		#player.bannedHitboxes.append([bullet,1])
		bullet.transform.x.x = player.transform.x.x
		bullet._velocity = Vector2(1000*player.transform.x.x,0)
		player.get_node("/root/Node2D/Articles").add_child(bullet)
		bullet.sleepDart = true
		bullet.attackWith("dartAttack")
		bullet.anim_sprite.play("arrow")


