extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var boardScene = load("res://source/characters/Godtest/hoverboard.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 40
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	player._velocity.x*=0.95
	player._velocity.y*=0.9
	player._velocity.y-=50
	if player.stateTimer==0:
		player.anim_sprite.play("shoot")
		player.get_node("/root/Node2D/AudioStreamPlayer").playSound(player.get_node("/root/Node2D/AudioStreamPlayer").spew)
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==24:
		
		var board = boardScene.instance()
		board.position = player.position + Vector2(10,0)*player.transform.x.x
		board.team = player.team
		#player.bannedHitboxes.append([board,1])
		#rock.transform.x.x = player.transform.x.x
		board._velocity = Vector2(20*player.transform.x.x,600) + player._velocity
		player.get_node("/root/Node2D/Articles").add_child(board)
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 12


