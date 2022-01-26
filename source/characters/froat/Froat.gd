extends Character

var jab = load("res://source/characters/Froat/jab.gd")
var dtilt = load("res://source/characters/Froat/dtilt.gd")
var utilt = load("res://source/characters/Froat/utilt.gd")
var bash = load("res://source/characters/Froat/bash.gd")
var uair = load("res://source/characters/Froat/uair.gd")
var dair = load("res://source/characters/Froat/dair.gd")
var ramm = load("res://source/characters/Froat/ramm.gd")
var upb = load("res://source/characters/Froat/upb.gd")
var spin = load("res://source/characters/Froat/spin.gd")
var eye = load("res://source/characters/Froat/eye.gd")
#var utilt = load("res://source/characters/Froat/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func attack():
	can_walljump = false
	state = 1
	stateTimer = 0
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	if not is_on_floor():
		if attackDirection.y<0:
			$currentAttack.set_script(uair)
		elif attackDirection.y>0:
			$currentAttack.set_script(dair)
		elif attackDirection.x*self.scale.y==0:
			$currentAttack.set_script(jab)
		else:
			$currentAttack.set_script(bash)
	else:
		if attackDirection.x*self.scale.y>0:
			$currentAttack.set_script(bash)
		elif attackDirection.y>0:
			$currentAttack.set_script(dtilt)
		elif attackDirection.y<0:
			$currentAttack.set_script(utilt)
		else:
			$currentAttack.set_script(jab)
	$currentAttack._ready()
	
func special():
	can_walljump = false
	state = 1
	stateTimer = 0
	if not is_on_floor():
		if direction.y<0:
			$currentAttack.set_script(upb)
		elif direction.y>0:
			$currentAttack.set_script(eye)
		elif direction.x*self.scale.y==0:
			$currentAttack.set_script(spin)
		else:
			$currentAttack.set_script(ramm)
	else:
		$currentAttack.set_script(ramm)
	$currentAttack._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
