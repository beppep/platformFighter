extends Sprite2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var expanding = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	scale=Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if expanding:
		scale.x+=0.1
		scale.y+=0.1
		if scale.x>=2:
			expanding=false
	else:
		scale.x-=0.05
		scale.y-=0.05
		if scale.x<=0:
			queue_free()
