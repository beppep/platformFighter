extends Character
"""
	grab = load("res://source/characters/Svampkoloni/attacks/grab.gd")
var jab = load("res://source/characters/Svampkoloni/attacks/jab.gd")
var uair = load("res://source/characters/Svampkoloni/attacks/uair.gd")
var utilt = load("res://source/characters/Svampkoloni/attacks/utilt.gd")
var ftilt = load("res://source/characters/Svampkoloni/attacks/ftilt.gd")
var dtilt = load("res://source/characters/Svampkoloni/attacks/dtilt.gd")
var bair = load("res://source/characters/Svampkoloni/attacks/bair.gd")
var nair = load("res://source/characters/Svampkoloni/attacks/nair.gd")
var dair = load("res://source/characters/Svampkoloni/attacks/dair.gd")
var upb = load("res://source/characters/Svampkoloni/attacks/upb.gd")
var sideb = load("res://source/characters/Svampkoloni/attacks/sideb.gd")
var downb = load("res://source/characters/Svampkoloni/attacks/transform.gd")
"""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func attack():
	grab_target = false
	can_walljump = false
	cant_hitfall = false
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
			$currentAttack.set_script(utilt)
		elif attackDirection.y>0:
			$currentAttack.set_script(dair)
		else:
			$currentAttack.set_script(jab)
	else:
		flip()
		if attackDirection.y<0:
			$currentAttack.set_script(utilt)
		elif attackDirection.y>0:
			$currentAttack.set_script(dtilt)
		else:
			$currentAttack.set_script(jab)
	
func special():
	grab_target = false
	can_walljump = false
	state = 1
	stateTimer = 0
	flip()
	if not is_on_floor():
		if direction.y<0:
			$currentAttack.set_script(upb)
		elif direction.y>0:
			$currentAttack.set_script(downb)
		elif direction.x != 0:
			state = 0
		else:
			state = 0
	else:
		if direction.y<0:
			$currentAttack.set_script(upb)
		elif direction.y>0:
			$currentAttack.set_script(downb)
		elif direction.x != 0:
			state = 0
		else:
			state = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
