extends Character

var bash = load("res://source/characters/Froat/bash.gd")
#var utilt = load("res://source/characters/Froat/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_id = 1


func attack():
	state = 1
	stateTimer = 0
	$currentAttack.set_script(bash)
	$currentAttack._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
