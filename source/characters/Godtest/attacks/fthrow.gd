extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var boardScene = load("res://source/characters/Godtest/hoverboard/hoverboard.tscn")


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	endFrame = 40
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fthrow")
	if player.stateTimer == 2:
		player.get_node("Hoverboard").visible = false
	#if player.stateTimer<18:
	player._velocity.y *= 0.8
	player._velocity.y -= 30
	if player.stateTimer==18:
		
		var board = boardScene.instantiate()
		board.transform.x.x = player.transform.x.x
		board.position = player.position+Vector2(0,-20)
		var direction = player.direction
		if direction==Vector2.ZERO:
			direction = Vector2(player.transform.x.x,0)
		board._velocity = direction.normalized()*1000 + player._velocity
		board.z_index = -2
		board.team = player.team
		player.get_node("/root/Node2D/Articles").add_child(board)
		board.attackWith("fthrow")
		player.boardObject = board
		board.ownerObject = player
		
		#player._velocity = (Vector2(0,-2) - direction) * 100
		
		player.hasHoverboard = false
		player.double_jumps = 1
		#player._velocity += Vector2(0, -2000)
	


