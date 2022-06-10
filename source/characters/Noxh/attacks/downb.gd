extends Attack
class_name DownB

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
func update():
	if player.stateTimer < 10:
		player._velocity.x*=0.95
		player._velocity.y*=0.7
		player._velocity.y-=40
	if player.stateTimer==0:
		player.anim_sprite.play("downb")
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==10:
		player._velocity.y-=900
		player._velocity.x-=200*player.transform.x.x
		
		var bullet = bulletScene.instance()
		bullet.position = player.position + Vector2(10,0)*player.transform.x.x
		bullet.team = player.team
		#bullet.ownererr = self #taken name
		#player.bannedHitboxes.append([bullet,1])
		bullet.transform.x.x = player.transform.x.x
		bullet._velocity = Vector2(1000*player.transform.x.x,2000)
		player.get_node("/root/Node2D/Articles").add_child(bullet)
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 6


