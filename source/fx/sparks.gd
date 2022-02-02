extends AnimatedSprite


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var timer  = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("boom")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer+=1
	if timer == 24:
		self.queue_free()
