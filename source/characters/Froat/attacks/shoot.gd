extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var rockScene = load("res://source/characters/Froat/rock.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 40
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	player._velocity*=0.9
	player._velocity.y-=50
	if player.stateTimer==0:
		player.anim_sprite.play("shoot")
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==24:
		
		var rock = rockScene.instance()
		rock.position = player.position + Vector2(10,0)*player.transform.x.x
		rock.team = -1# player.team
		player.bannedHitboxes.append([rock,1])
		#rock.transform.x.x = player.transform.x.x
		rock._velocity = Vector2(300*player.transform.x.x,-600) + player._velocity
		$"/root/Node2D/Articles".add_child(rock)
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 16


