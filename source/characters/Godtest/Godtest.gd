extends Character

var jab = load("res://source/characters/Godtest/attacks/jab.gd")
var uair = load("res://source/characters/Godtest/attacks/uair.gd")
var ftilt = load("res://source/characters/Godtest/attacks/ftilt.gd")
var dtilt = load("res://source/characters/Godtest/attacks/dtilt.gd")
var bair = load("res://source/characters/Godtest/attacks/bair.gd")
var nair = load("res://source/characters/Godtest/attacks/nair.gd")
var dair = load("res://source/characters/Godtest/attacks/dair.gd")
var upb = load("res://source/characters/Godtest/attacks/upb.gd")
var sideb = load("res://source/characters/Godtest/attacks/sideb.gd")
#var utilt = load("res://source/characters/Godtest/attacks/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	grab = load("res://source/characters/Godtest/attacks/grab.gd")


func attack():
	can_walljump = false
	state = 1
	stateTimer = 0
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not is_on_ground:
		if attackDirection.y<0:
			$currentAttack.set_script(uair)
		elif attackDirection.y>0:
			$currentAttack.set_script(dair)
		elif attackDirection.x>0:
			$currentAttack.set_script(ftilt)
		elif attackDirection.x<0:
			$currentAttack.set_script(bair)
		else:
			$currentAttack.set_script(nair)
	else:
		if attackDirection.y<0:
			$currentAttack.set_script(uair)
		elif attackDirection.y>0:
			$currentAttack.set_script(dtilt)
		elif attackDirection.x>0:
			$currentAttack.set_script(ftilt)
		else:
			$currentAttack.set_script(jab)
	
func special():
	can_walljump = false
	state = 1
	stateTimer = 0
	if not is_on_floor():
		if direction.y<0:
			$currentAttack.set_script(upb)
		elif direction.x != 0:
			flip()
			$currentAttack.set_script(sideb)
		else:
			$currentAttack.set_script(sideb)
	else:
		if direction.x != 0:
			$currentAttack.set_script(sideb)
		else:
			$currentAttack.set_script(sideb)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
