extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

#onready var audioPlayer: AudioStreamPlayer = get_node("AudioStreamPlayer") 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var players = $Players.get_children()
	for player in players:
		player.inputAction() #never check anything here
	for player in players:
		player.hitCollision() #only check things here
	for player in players:
		player.hitEffect() #never check anything here
