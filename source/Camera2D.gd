extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var screenShake = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var players = get_node("../Players").get_children()
	var pos = Vector2(0,0)
	for player in players:
		pos += player.position
	pos = pos / len(players) # just average pos
	if screenShake>0:
		rng.randomize() #test
		pos += Vector2((rng.randf()-0.5),(rng.randf()-0.5))*screenShake*20  #test
		screenShake -= 1
	set_offset( pos*0.1 + get_offset()*0.9 )
	$"/root/Node2D/stage/CanvasLayer".offset = -pos/10
	if len(players)<2:
		return
	var zoom = max(abs(players[0].position.x-players[1].position.x), 1.5*abs(players[0].position.y-players[1].position.y))
	zoom = zoom*0.001 + 0.5
	zoom = Vector2(1/zoom,1/zoom)
	if zoom<get_zoom():
		set_zoom( zoom )
	else:
		set_zoom( zoom*0.02 + get_zoom()*0.98 )
