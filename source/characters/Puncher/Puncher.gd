extends Character

var jab = load("res://source/characters/Puncher/jab.gd") 
var upb = load("res://source/characters/Puncher/upb.gd") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func attack():
	state = 1
	stateTimer = 0
	if direction.y:
		$currentAttack.set_script(upb)
	else:
		$currentAttack.set_script(jab)
	$currentAttack._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame. #FPS
#func _process(delta):
#	pass
