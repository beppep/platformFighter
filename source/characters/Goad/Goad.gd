extends "res://source/character.gd"



var B_charge = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_shield_float = true
	can_air_dash = true
	attacks = {
		"grab": load("res://source/characters/Goad/attacks/grab.gd"),
		"throw": load("res://source/characters/Goad/attacks/throw.gd"),
		"jab": load("res://source/characters/Goad/attacks/jab.gd"),
		"jab2": load("res://source/characters/Goad/attacks/jab2.gd"),
		"jab3": load("res://source/characters/Goad/attacks/jab3.gd"),
		"dtilt": load("res://source/characters/Goad/attacks/dtilt.gd"),
		"ftilt": load("res://source/characters/Goad/attacks/ftilt.gd"),
		"utilt": load("res://source/characters/Goad/attacks/utilt.gd"),
		"nair": load("res://source/characters/Goad/attacks/bash.gd"),
		"uair": load("res://source/characters/Goad/attacks/uair.gd"),
		"dair": load("res://source/characters/Goad/attacks/dair.gd"),
		"bair": load("res://source/characters/Goad/attacks/bair.gd"),
		"fair": load("res://source/characters/Goad/attacks/fair.gd"),
		"nb": load("res://source/characters/Goad/attacks/ramm.gd"),
		"fb": load("res://source/characters/Goad/attacks/ramm.gd"),
		"ub": load("res://source/characters/Goad/attacks/upb.gd"),
		"db": load("res://source/characters/Goad/attacks/downb.gd"),
		"usmash": load("res://source/characters/Goad/attacks/upb.gd"),
		"dsmash": load("res://source/characters/Goad/attacks/dsmash.gd"),
		"fsmash": load("res://source/characters/Goad/attacks/ramm.gd"),
	}

func regain_resources():
	B_charge = true

func attack():
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not is_on_ground:
		if attackDirection.y<0:
			attackWith("uair")
		elif attackDirection.y>0:
			attackWith("dair")
		elif attackDirection.x>0:
			attackWith("fair")
		elif attackDirection.x<0:
			attackWith("bair")
		else:
			attackWith("nair")
	else:
		if attackDirection.x>0:
			attackWith("ftilt")
		elif attackDirection.x<0:
			transform.x.x *= -1
			attackWith("ftilt")
		elif attackDirection.y>0:
			attackWith("dtilt")
		elif attackDirection.y<0:
			attackWith("utilt")
		else:
			attackWith("jab")
	
func special():
	flip()
	if not is_on_ground:
		if direction.y<0:
			attackWith("ub")
		elif direction.y>0:
			attackWith("db")
		elif direction.x==0:
			if B_charge:
				attackWith("nb")
				B_charge = false
			else:
				state = 0
				stateTimer = 0
		else:
			attackWith("fb")
	else:
		if direction.y<0:
			attackWith("usmash")
		elif direction.y>0:
			attackWith("dsmash")
		elif direction.x==0:
			attackWith("nb")
		else:
			attackWith("fsmash")

func grab():
	flip() #?
	attackWith("grab")
