extends Character

var jab = load("res://source/characters/Froat/jab.gd")
var dtilt = load("res://source/characters/Froat/dtilt.gd")
var bash = load("res://source/characters/Froat/bash.gd")
var uair = load("res://source/characters/Froat/uair.gd")
var dair = load("res://source/characters/Froat/dair.gd")
#var utilt = load("res://source/characters/Froat/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_id = 1
	pass


func attack():
	state = 1
	stateTimer = 0
	if not is_on_floor():
		if direction.y<0:
			$currentAttack.set_script(uair)
		elif direction.y>0:
			$currentAttack.set_script(dair)
		elif direction.x*self.scale.y==0:
			$currentAttack.set_script(jab)
		else:
			$currentAttack.set_script(bash)
	else:
		if direction.x*self.scale.y>0:
			$currentAttack.set_script(bash)
		elif direction.y>0:
			$currentAttack.set_script(dtilt)
		else:
			$currentAttack.set_script(jab)
	$currentAttack._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
