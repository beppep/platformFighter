extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var players = get_node("../Players").get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pos = Vector2(0,0)
	for player in players:
		pos += player.position
	pos = pos / len(players) # just average pos
	set_offset( pos*0.05 + get_offset()*0.95 )
	var zoom = players[0].position.distance_to(players[1].position)*0.001 + 0.5
	zoom = Vector2(zoom,zoom)
	if zoom>get_zoom():
		set_zoom( zoom )
	else:
		set_zoom( zoom*0.01 + get_zoom()*0.99 )
