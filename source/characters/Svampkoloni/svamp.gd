extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var timer  = 0
var gravity = 20
var _velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transform.x.x = 1.5
	transform.y.y = 1.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_velocity.y += gravity
	_velocity = move_and_slide(_velocity)
	timer+=1
	if timer == 6:
		transform.x.x = 1
		transform.y.y = 1
	if timer == 300:
		transform.x.x = 0.5
		transform.y.y = 0.5
	if timer == 600:
		queue_free()
