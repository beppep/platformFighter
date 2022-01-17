extends Character

var jab = load("res://source/characters/Ninja/jab.gd") 
var utilt = load("res://source/characters/Ninja/utilt.gd") 
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_id = 1


func attack():
	state = 1
	if direction.x:
		$currentAttack.set_script(jab)
	else:
		$currentAttack.set_script(utilt)
	$currentAttack._ready()
	stateTimer = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
