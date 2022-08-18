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
	player._velocity.x*=0.95
	player._velocity.y*=0.9
	player._velocity.y-=50
	if player.stateTimer==0:
		player.anim_sprite.play("dthrow")
	if player.stateTimer < 6:
		player.reverse()
	if player.stateTimer==24:
		
		var board = boardScene.instance()
		board.transform.x.x = player.transform.x.x
		board.position = player.position+Vector2(0,40)
		board._velocity = Vector2(20*player.transform.x.x,1000) + player._velocity
		board.z_index = -2
		board.team = player.team
		player.get_node("/root/Node2D/Articles").add_child(board)
		player.boardObject = board
		board.ownerObject = player
		
		#earlier?
		player.get_node("Hoverboard").visible = false
		player.hasHoverboard = false
		player.double_jumps = 1
		player._velocity += Vector2(0, -2000)
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 12


