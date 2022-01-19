extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var players = get_node("../Players").get_children()
var pos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pos = Vector2(0,-300)
	for player in players:
		pos += player.position
	pos = pos / len(players) # just average pos
	set_offset( pos*0.2 + get_offset()*0.8 )
