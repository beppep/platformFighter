extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var rng = RandomNumberGenerator.new()


var punch = load("res://assets/sounds/punch.wav")
var hit = load("res://assets/sounds/meleepunch.wav")
var shieldHit = load("res://assets/sounds/shieldHit.wav")
var waveland = load("res://assets/sounds/whoosh3.wav")
var shine = load("res://assets/sounds/shine.wav")
var spew = load("res://assets/sounds/froat/spew.wav")
var groat1 = load("res://assets/sounds/froat/groat1.wav")
var groat2 = load("res://assets/sounds/froat/groat2.wav")
var rocks = load("res://assets/sounds/froat/rocks.wav")
var tech = load("res://assets/sounds/tech.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func playSound(sound, pitch=1):
	stream = sound
	#rng.randomize()
	pitch_scale = pitch#rng.randf_range(-0.5, 2.0)
	play()
